package com.psgpw.pickapp

import `in`.madapps.placesautocomplete.PlaceAPI
import `in`.madapps.placesautocomplete.adapter.PlacesAutoCompleteAdapter
import `in`.madapps.placesautocomplete.model.Place
import android.R.attr
import android.app.DatePickerDialog
import android.content.Intent
import android.graphics.Color
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.InputType
import android.util.Log
import android.view.View
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import androidx.navigation.fragment.findNavController
import com.google.android.gms.common.api.Status
import com.google.android.libraries.places.api.Places
import com.google.android.libraries.places.widget.AutocompleteSupportFragment
import com.google.android.libraries.places.widget.listener.PlaceSelectionListener
import com.psgpw.pickapp.data.DataStoreManager
import com.psgpw.pickapp.data.models.AddSenderOrDeliverRequest
import com.psgpw.pickapp.data.models.BaseRequest
import com.psgpw.pickapp.data.network.ADD_DELIVER_ID
import com.psgpw.pickapp.data.network.ADD_SENDER_ID
import com.psgpw.pickapp.data.network.GET_DELIVER_ID
import com.psgpw.pickapp.databinding.ActivitySendOrDeliverBinding
import com.psgpw.pickapp.domain.ResultState
import com.psgpw.pickapp.utils.isValidEmail
import com.psgpw.pickapp.utils.showAlert
import com.psgpw.pickapp.utils.toastShow
import com.psgpw.pickapp.viewmodels.AddSenderOrDeliverViewModel
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.runBlocking
import java.util.*
import androidx.core.app.ActivityCompat.startActivityForResult

import com.google.android.libraries.places.widget.model.AutocompleteActivityMode

import com.google.android.libraries.places.widget.Autocomplete
import android.R.attr.data
import android.app.Activity
import android.app.TimePickerDialog
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.text.Editable
import android.text.TextUtils
import android.text.TextWatcher
import android.view.ViewGroup
import android.widget.*

import com.google.android.libraries.places.widget.AutocompleteActivity
import kotlinx.coroutines.launch
import java.io.InputStreamReader


class SendOrDeliverActivity : AppCompatActivity() {
    lateinit var apiKey: String

    // var email: String? = null
    // var phoneNumber: String? = null
    lateinit var placeSearch: String
    lateinit var requestType: String
    lateinit var dateValue: String
    lateinit var countryCode: String
    lateinit var filter: ProfanityFilter
    lateinit var watcher: TextWatcher

    private lateinit var binding: ActivitySendOrDeliverBinding
    private val viewModel: AddSenderOrDeliverViewModel by viewModels<AddSenderOrDeliverViewModel>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySendOrDeliverBinding.inflate(layoutInflater)
        filter = ProfanityFilter()
        filter.buildDictionaryTree(InputStreamReader(getAssets().open("badwords.txt")))

        binding.edtDate.getEditText().isFocusableInTouchMode = false

        val array = resources.getStringArray(R.array.country_code)
        array.sort()
        val adapter: ArrayAdapter<String> = ArrayAdapter<String>(
            this,
            R.layout.item_spiner, array
        )
        binding.countrySpinner.setAdapter(adapter)

        binding.countrySpinner.onItemSelectedListener =
            object : AdapterView.OnItemSelectedListener {
                override fun onNothingSelected(parent: AdapterView<*>?) {

                }

                override fun onItemSelected(
                    parent: AdapterView<*>?,
                    view: View?,
                    position: Int,
                    id: Long
                ) {
                    countryCode = array[position]
                }

            }

        val placesApi =
            PlaceAPI.Builder().apiKey(getGoogleApiKey()).build(this)
        binding.autoCompleteEditTextDeparture.setAdapter(PlacesAutoCompleteAdapter(this, placesApi))
        binding.autoCompleteEditTextDestination.setAdapter(
            PlacesAutoCompleteAdapter(
                this,
                placesApi
            )
        )

        binding.autoCompleteEditTextDeparture.onItemClickListener =
            AdapterView.OnItemClickListener { parent, _, position, _ ->
                val place = parent.getItemAtPosition(position) as Place
                binding.autoCompleteEditTextDeparture.setText(place.description)
            }

        binding.autoCompleteEditTextDestination.onItemClickListener =
            AdapterView.OnItemClickListener { parent, _, position, _ ->
                val place = parent.getItemAtPosition(position) as Place
                binding.autoCompleteEditTextDestination.setText(place.description)
            }


        lifecycleScope.launch {
            DataStoreManager(context = this@SendOrDeliverActivity).getUserApiKey()
                .collect {
                    apiKey = it
                }
        }
        lifecycleScope.launch {
            DataStoreManager(context = this@SendOrDeliverActivity).getRequestPhone()
                .collect {
                    binding.edtPhoneNumber.setText(it)
                }
        }

        lifecycleScope.launch {
            DataStoreManager(context = this@SendOrDeliverActivity).getRequestEmail()
                .collect {
                    binding.edtEmail.getEditText().setText(it)
                }
        }

        requestType = intent.getStringExtra("request_type").toString()


        watcher = (object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
            }

            override fun afterTextChanged(s: Editable?) {
                val sText = s.toString().lowercase()
                val filtered = filter.filterBadWords(sText)
                if (filtered.contains("**")) {
                    addComment(filtered)
                }
            }
        })

        binding.edtComment.getEditText().addTextChangedListener(watcher)

        binding.tvFindSenderDeliver.text =
            if (requestType == ADD_SENDER_ID) "or find your deliver" else "or find your sender"

        if (requestType == ADD_SENDER_ID) {
            binding.tvSubmitSender.visibility = View.VISIBLE
            binding.tvSubmitDeliver.visibility = View.GONE
            binding.tvFindSenderDeliver.background = null
        } else {
            binding.tvSubmitSender.visibility = View.GONE
            binding.tvSubmitDeliver.visibility = View.VISIBLE
            binding.tvFindSenderDeliver.setBackground(getDrawable(R.drawable.bg_border))

        }

        binding.tvFindSenderDeliver.setOnClickListener {
            if (requestType == ADD_SENDER_ID) {
                openHomeActivity("FIND_DELIVER")
            } else {
                openHomeActivity("FIND_SENDER")
            }
        }

        setUpToolbar(requestType)
        setUpDatePicker()

        binding.edtPhoneNumber.inputType = InputType.TYPE_CLASS_PHONE
        binding.edtFee.getEditText().inputType = InputType.TYPE_CLASS_NUMBER

        binding.edtEmail.getEditText().isValidEmail("Valid Email address required")

        binding.tvSubmitSender.setOnClickListener {
            callAPI()
        }

        binding.tvSubmitDeliver.setOnClickListener {
            callAPI()
        }

        setContentView(binding.root)
    }

    private fun getGoogleApiKey(): String {
        //get the KEY value from the meta-data in AndroidManifest
        val ai: ApplicationInfo = applicationContext.packageManager
            .getApplicationInfo(applicationContext.packageName, PackageManager.GET_META_DATA)
        val value = ai.metaData["googleKey"]
        return value.toString()
    }

    private fun addComment(text: String) {
        binding.edtComment.getEditText().removeTextChangedListener(watcher)

        binding.edtComment.getEditText().setText(text)
        binding.edtComment.getEditText().setSelection(binding.edtComment.getEditText().length())
        binding.edtComment.getEditText().addTextChangedListener(watcher)
    }

    private fun callAPI() {
        if (isAllValidationSuccess()) {
            viewModel.addSenderOrDeliver(createRequest(requestType))
            viewModel.dataState.observe(this, Observer {
                when (it) {
                    is ResultState.Loading -> binding.progress.progressBar.visibility =
                        View.VISIBLE
                    is ResultState.Error -> {
                        binding.progress.progressBar.visibility = View.GONE
                        Toast.makeText(this, it.exception.message, Toast.LENGTH_SHORT).show()
                    }
                    is ResultState.Success -> {
                        binding.progress.progressBar.visibility = View.GONE
                        //Toast.makeText(this, it.data.message, Toast.LENGTH_SHORT).show()
                        this.showAlert("Your request has been successfully submitted!")
                        lifecycleScope.launch {
                            DataStoreManager(this@SendOrDeliverActivity).setEmailForSenderOrDeliverRequest(
                                binding.edtEmail.getEditText().text.toString()
                            )
                        }
                        lifecycleScope.launch {
                            DataStoreManager(this@SendOrDeliverActivity).setPhoneNumberForSenderOrDeliverRequest(
                                binding.edtPhoneNumber.text.toString()
                            )

                        }
                        resetView()
                    }
                }
            })
        } else {
            Toast.makeText(this, "Please enter required field", Toast.LENGTH_SHORT).show()
        }
    }

    private fun openHomeActivity(key: String) {
        val intent = Intent(this, HomeActivity::class.java)
        intent.putExtra("NAVIGATE_KEY", key)
        startActivity(intent)
    }

    private fun resetView() {
        binding.apply {
            autoCompleteEditTextDeparture.setText("")
            autoCompleteEditTextDestination.setText("")
            edtDate.getEditText().setText("")
            edtFee.getEditText().setText("")
            edtComment.getEditText().setText("")
            edtPhoneNumber.setText("")
            edtEmail.getEditText().setText("")
        }
    }

    private fun setUpToolbar(title: String) {
        binding.toolbar.tvTitle.text =
            if (title == ADD_SENDER_ID) "Send Request" else "Delivery Request"


        binding.tvSenderDeliverText.text =
            if (title == ADD_SENDER_ID) "I want to send" else "I want to deliver"

        binding.toolbar.ivUserProfile.setOnClickListener {
            openHomeActivity("SETTING")
        }
        binding.toolbar.ivBack.setOnClickListener {
            finish()
        }
    }

    private fun isAllValidationSuccess(): Boolean {
        return binding.run {
            autoCompleteEditTextDeparture.text.toString().isNotEmpty() &&
                    autoCompleteEditTextDestination.text.toString().isNotEmpty() &&
                    edtDate.getEditText().text.toString().isNotEmpty() &&
                    edtFee.getEditText().text.toString().isNotEmpty() &&
                    // edtComment.getEditText().text.toString().isNotEmpty() &&
                    edtPhoneNumber.text.toString().isNotEmpty() &&
                    edtEmail.getEditText().text.toString().isValidEmail()
        }
    }

    private fun setUpDatePicker() {
        val c = Calendar.getInstance()
        val year = c.get(Calendar.YEAR)
        val month = c.get(Calendar.MONTH)
        val day = c.get(Calendar.DAY_OF_MONTH)
        val startHour = c.get(Calendar.HOUR_OF_DAY)
        val startMinute = c.get(Calendar.MINUTE)

        binding.edtDate.getEditText().setOnClickListener {
            this.let {
                val dialog = DatePickerDialog(
                    it, { view, year, monthOfYear, dayOfMonth ->
                        with(binding) {
                            val timeDialog = TimePickerDialog(
                                it,
                                TimePickerDialog.OnTimeSetListener { _, hour, minute ->
                                    dateValue =
                                        "$year-${if (monthOfYear >= 0 && monthOfYear < 10) "0${monthOfYear + 1}" else "${monthOfYear + 1}"}-${if (dayOfMonth > 0 && dayOfMonth < 10) "0${dayOfMonth}" else "$dayOfMonth"}"
                                    edtDate.getEditText()
                                        .setText(dateValue + " " + hour + ":" + minute)
                                },
                                startHour,
                                startMinute,
                                false
                            )
                            timeDialog.show()
                            timeDialog.getButton(DatePickerDialog.BUTTON_POSITIVE)
                                .setTextColor(Color.WHITE)
                            timeDialog.getButton(DatePickerDialog.BUTTON_NEGATIVE)
                                .setTextColor(Color.WHITE)
                        }
                    },
                    year,
                    month,
                    day
                )
                dialog.show()
                dialog.getButton(DatePickerDialog.BUTTON_POSITIVE).setTextColor(Color.WHITE)
                dialog.getButton(DatePickerDialog.BUTTON_NEGATIVE).setTextColor(Color.WHITE)

            }
        }


        binding.edtDate.setOnClickListener {
            this.let {
                val dialog = DatePickerDialog(
                    it, { view, year, monthOfYear, dayOfMonth ->
                        with(binding) {
                            val timeDialog = TimePickerDialog(
                                it,
                                TimePickerDialog.OnTimeSetListener { _, hour, minute ->
                                    dateValue =
                                        "$year-${if (monthOfYear >= 0 && monthOfYear < 10) "0${monthOfYear + 1}" else "${monthOfYear + 1}"}-${if (dayOfMonth > 0 && dayOfMonth < 10) "0${dayOfMonth}" else "$dayOfMonth"}"
                                    edtDate.getEditText()
                                        .setText(dateValue + " " + hour + ":" + minute)
                                },
                                startHour,
                                startMinute,
                                false
                            )
                            timeDialog.show()
                            timeDialog.getButton(DatePickerDialog.BUTTON_POSITIVE)
                                .setTextColor(Color.WHITE)
                            timeDialog.getButton(DatePickerDialog.BUTTON_NEGATIVE)
                                .setTextColor(Color.WHITE)
                        }
                    },
                    year,
                    month,
                    day
                )
                dialog.show()
                dialog.getButton(DatePickerDialog.BUTTON_POSITIVE).setTextColor(Color.WHITE)
                dialog.getButton(DatePickerDialog.BUTTON_NEGATIVE).setTextColor(Color.WHITE)

            }
        }
    }

    private fun createRequest(id: String): BaseRequest {

        return AddSenderOrDeliverRequest(
            id = id,
            date = dateValue,
            departure = binding.autoCompleteEditTextDeparture.text.toString(),
            destination = binding.autoCompleteEditTextDestination.text.toString(),
            apikey = apiKey,
            fee = binding.edtFee.getEditText().text.toString(),
            comment = binding.edtComment.getEditText().text.toString(),
            phone = countryCode + "" + binding.edtPhoneNumber.text.toString(),
            email = binding.edtEmail.getEditText().text.toString(),
            viewEmail = true,
            viewPhone = true
        )
    }
}