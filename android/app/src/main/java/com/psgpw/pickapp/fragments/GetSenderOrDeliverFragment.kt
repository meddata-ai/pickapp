package com.psgpw.pickapp.fragments

import `in`.madapps.placesautocomplete.PlaceAPI
import `in`.madapps.placesautocomplete.adapter.PlacesAutoCompleteAdapter
import android.annotation.SuppressLint
import android.app.DatePickerDialog
import android.app.TimePickerDialog
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Color
import com.psgpw.pickapp.adapters.SenderDeliverAdapter.ClickListener
import com.psgpw.pickapp.adapters.SenderDeliverAdapter
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.ViewGroup
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.AdapterView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.android.gms.common.api.Status
import com.google.android.libraries.places.api.Places
import com.google.android.libraries.places.api.model.Place
import com.google.android.libraries.places.widget.Autocomplete
import com.google.android.libraries.places.widget.AutocompleteActivity
import com.google.android.libraries.places.widget.AutocompleteSupportFragment
import com.google.android.libraries.places.widget.listener.PlaceSelectionListener
import com.google.android.libraries.places.widget.model.AutocompleteActivityMode
import com.michalsvec.singlerowcalendar.calendar.CalendarChangesObserver
import com.michalsvec.singlerowcalendar.calendar.CalendarViewManager
import com.michalsvec.singlerowcalendar.calendar.SingleRowCalendar
import com.michalsvec.singlerowcalendar.calendar.SingleRowCalendarAdapter
import com.michalsvec.singlerowcalendar.selection.CalendarSelectionManager
import com.michalsvec.singlerowcalendar.utils.DateUtils
import com.psgpw.pickapp.R
import com.psgpw.pickapp.SendOrDeliverActivity
import com.psgpw.pickapp.data.models.BaseRequest
import com.psgpw.pickapp.data.models.GetSenderOrDeliverRequest
import com.psgpw.pickapp.data.models.SenderOrDeliver
import com.psgpw.pickapp.data.network.ADD_DELIVER_ID
import com.psgpw.pickapp.data.network.ADD_SENDER_ID
import com.psgpw.pickapp.data.network.GET_DELIVER_ID
import com.psgpw.pickapp.data.network.GET_SENDER_ID
import com.psgpw.pickapp.databinding.CalendarSelectedItemBinding
import com.psgpw.pickapp.databinding.FragmentGetSenderDeliverBinding
import com.psgpw.pickapp.domain.ResultState
import com.psgpw.pickapp.utils.showAlert
import com.psgpw.pickapp.viewmodels.SenderOrDeliverListViewModel
import java.util.*
import kotlin.collections.ArrayList
import kotlin.concurrent.fixedRateTimer
import kotlin.math.sin

class GetSenderOrDeliverFragment : Fragment(), ClickListener {
    private val senderDeliverViewModel: SenderOrDeliverListViewModel by viewModels<SenderOrDeliverListViewModel>()
    private lateinit var adapter: SenderDeliverAdapter
    private var adapterData: ArrayList<SenderOrDeliver> = ArrayList()
    private lateinit var recyclerView: RecyclerView
    private var requestType: String? = null
    lateinit var placeSearch: String

    private val calendar = Calendar.getInstance()
    private lateinit var singleRowCalendar: SingleRowCalendar
    private var currentMonth = 0
    private var tvDate: TextView? = null
    private var tvDay: TextView? = null
    private var previosDate: Date? = null
    lateinit var dateValue: String

    private lateinit var binding: FragmentGetSenderDeliverBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?, savedInstanceState: Bundle?
    ): View? {
        binding = FragmentGetSenderDeliverBinding.inflate(inflater, container, false)

        recyclerView = binding.rvSenderDeliver

        val c = Calendar.getInstance()
        val year = c.get(Calendar.YEAR)
        val month = c.get(Calendar.MONTH)
        val day = c.get(Calendar.DAY_OF_MONTH)
        val startHour = c.get(Calendar.HOUR_OF_DAY)
        val startMinute = c.get(Calendar.MINUTE)

        binding.tvFind.setOnClickListener {
            callAPI()
        }
        binding.edtDate.getEditText().isFocusableInTouchMode = false

        val placesApi =
            PlaceAPI.Builder().apiKey(getGoogleApiKey())
                .build(requireContext())
        binding.autoCompleteEditTextDeparture.setAdapter(
            PlacesAutoCompleteAdapter(
                requireContext(),
                placesApi
            )
        )
        binding.autoCompleteEditTextDestination.setAdapter(
            PlacesAutoCompleteAdapter(
                requireContext(),
                placesApi
            )
        )

        binding.autoCompleteEditTextDeparture.onItemClickListener =
            AdapterView.OnItemClickListener { parent, _, position, _ ->
                val place =
                    parent.getItemAtPosition(position) as `in`.madapps.placesautocomplete.model.Place
                binding.autoCompleteEditTextDeparture.setText(place.description)
            }

        binding.autoCompleteEditTextDestination.onItemClickListener =
            AdapterView.OnItemClickListener { parent, _, position, _ ->
                val place =
                    parent.getItemAtPosition(position) as `in`.madapps.placesautocomplete.model.Place
                binding.autoCompleteEditTextDestination.setText(place.description)
            }

        binding.edtDate.getEditText().setOnClickListener {
            context?.let {
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
                                    calendar.set(Calendar.YEAR, year)
                                    calendar.set(Calendar.DAY_OF_MONTH, 1)
                                    calendar.set(Calendar.MONTH, monthOfYear)
                                    currentMonth = calendar[Calendar.MONTH]
                                    singleRowCalendar.setDates(getDates(mutableListOf(), calendar))
                                    calendar.set(Calendar.DAY_OF_MONTH, dayOfMonth)
                                    singleRowCalendar.initialPositionIndex =
                                        calendar.get(Calendar.DAY_OF_MONTH) - 1
                                    singleRowCalendar.init()
                                    singleRowCalendar.select(calendar.get(Calendar.DAY_OF_MONTH) - 1)
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
            context?.let {
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
                                    calendar.set(Calendar.YEAR, year)
                                    calendar.set(Calendar.DAY_OF_MONTH, 1)
                                    calendar.set(Calendar.MONTH, monthOfYear)
                                    currentMonth = calendar[Calendar.MONTH]
                                    singleRowCalendar.setDates(getDates(mutableListOf(), calendar))
                                    calendar.set(Calendar.DAY_OF_MONTH, dayOfMonth)
                                    singleRowCalendar.initialPositionIndex =
                                        calendar.get(Calendar.DAY_OF_MONTH) - 1
                                    singleRowCalendar.init()
                                    singleRowCalendar.select(calendar.get(Calendar.DAY_OF_MONTH) - 1)
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

        adapter = SenderDeliverAdapter(context!!, this, adapterData)
        recyclerView.adapter = adapter
        recyclerView.layoutManager = LinearLayoutManager(context)

        return binding.root;
    }

    private fun getGoogleApiKey(): String {
        //get the KEY value from the meta-data in AndroidManifest
        val ai: ApplicationInfo = requireContext().packageManager
            .getApplicationInfo(requireContext().packageName, PackageManager.GET_META_DATA)
        val value = ai.metaData["googleKey"]
        return value.toString()
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        requestType = arguments?.getString("request_type")
        setUpToolbar(if (requestType == GET_SENDER_ID) "Find Your Sender" else "Find Your Courier")
        calendar.time = Date()
        currentMonth = calendar[Calendar.MONTH]
        setupCalendar()
        binding.newRequest.setOnClickListener {
            openSenderOrDeliverActivity(if (requestType == GET_SENDER_ID) ADD_DELIVER_ID else ADD_SENDER_ID)
        }
    }

    private fun setupCalendar() {
        //calendar.time = Date()
        currentMonth = calendar[Calendar.MONTH]
        val dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH) - 1

        val myCalendarChangesObserver = object : CalendarChangesObserver {
            override fun whenWeekMonthYearChanged(
                weekNumber: String,
                monthNumber: String,
                monthName: String,
                year: String,
                date: Date
            ) {
                binding.tvMonthYear.text =
                    "${DateUtils.getMonthName(date)} ${DateUtils.getYear(date)}"
                super.whenWeekMonthYearChanged(weekNumber, monthNumber, monthName, year, date)
            }

            override fun whenSelectionChanged(isSelected: Boolean, position: Int, date: Date) {
                if (date != previosDate) {
                    previosDate = date
                    val year = DateUtils.getYear(date)
                    val monthOfYear = DateUtils.getMonthNumber(date).toInt()
                    val dayOfMonth = DateUtils.getDayNumber(date).toInt()
                    val cal = Calendar.getInstance()
                    val startHour = cal.get(Calendar.HOUR_OF_DAY)
                    val startMinute = cal.get(Calendar.MINUTE)
                    dateValue =
                        "${year}-${if (monthOfYear >= 0 && monthOfYear < 10) "0" + monthOfYear else monthOfYear}-${if (dayOfMonth >= 0 && dayOfMonth < 10) "0" + dayOfMonth else dayOfMonth}"
                    binding.edtDate.getEditText()
                        .setText("${year}-${if (monthOfYear >= 0 && monthOfYear < 10) "0" + monthOfYear else monthOfYear}-${if (dayOfMonth >= 0 && dayOfMonth < 10) "0" + dayOfMonth else dayOfMonth}" + " " + startHour + ":" + startMinute)
//                    if (isSelected) {
//                        callAPI()
//                    }
                }
                super.whenSelectionChanged(isSelected, position, date)
            }

            override fun whenCalendarScrolled(dx: Int, dy: Int) {
                super.whenCalendarScrolled(dx, dy)
            }

            override fun whenSelectionRestored() {

                super.whenSelectionRestored()
            }

            override fun whenSelectionRefreshed() {

                super.whenSelectionRefreshed()
            }
        }

        val myCalendarViewManager = object : CalendarViewManager {
            override fun setCalendarViewResourceId(
                position: Int,
                date: Date,
                isSelected: Boolean
            ): Int {
                // return item layout files, which you have created
                val cal = Calendar.getInstance()
                cal.time = date
                return R.layout.calendar_selected_item
            }

            override fun bindDataToCalendarView(
                holder: SingleRowCalendarAdapter.CalendarViewHolder,
                date: Date,
                position: Int,
                isSelected: Boolean
            ) {
                // bind data to calendar item views
                tvDate = holder.itemView.findViewById<TextView>(R.id.tv_date_calendar_item)
                tvDate?.setText(DateUtils.getDayNumber(date))
                tvDay = holder.itemView.findViewById<TextView>(R.id.tv_day_calendar_item)
                tvDay?.setText(DateUtils.getDay3LettersName(date))
                if (isSelected) {
                    tvDate?.background = resources.getDrawable(R.drawable.shape_oval_white)
                    tvDate?.setTextColor(resources.getColor(R.color.primary_dark))
                } else {
                    tvDate?.background = null
                    tvDate?.setTextColor(resources.getColor(R.color.rv_bg_color))
                }
                // bindingCal?.tvDateCalendarItem?.text = DateUtils.getDayNumber(date)
                //bindingCal?.tvDayCalendarItem?.text = DateUtils.getDay3LettersName(date)
            }
        }

        val mySelectionManager = object : CalendarSelectionManager {
            override fun canBeItemSelected(position: Int, date: Date): Boolean {
//                val cal = Calendar.getInstance()
//                cal.time = date
                return true
            }

        }

        singleRowCalendar = binding.mainSingleRowCalendar.apply {
            calendarViewManager = myCalendarViewManager
            calendarChangesObserver = myCalendarChangesObserver
            calendarSelectionManager = mySelectionManager
            futureDaysCount = 30
            includeCurrentDate = true
            setDates(getFutureDatesOfCurrentMonth())

            initialPositionIndex = dayOfMonth
            init()
            select(dayOfMonth)
        }

        binding.btnLeft.setOnClickListener {
            singleRowCalendar.setDates(getDatesOfPreviousMonth())
            singleRowCalendar.init()
        }

        binding.btnRight.setOnClickListener {
            singleRowCalendar.setDates(getDatesOfNextMonth())
            singleRowCalendar.init()
        }
    }

    private fun getDatesOfNextMonth(): List<Date> {
        currentMonth++ // + because we want next month
        if (currentMonth == 12) {
            // we will switch to january of next year, when we reach last month of year
            calendar.set(Calendar.YEAR, calendar[Calendar.YEAR] + 1)
            currentMonth = 0 // 0 == january
        }
        return getDates(mutableListOf())
    }

    private fun getDatesOfPreviousMonth(): List<Date> {
        currentMonth-- // - because we want previous month
        if (currentMonth == -1) {
            // we will switch to december of previous year, when we reach first month of year
            calendar.set(Calendar.YEAR, calendar[Calendar.YEAR] - 1)
            currentMonth = 11 // 11 == december
        }
        return getDates(mutableListOf())
    }

    private fun getFutureDatesOfCurrentMonth(): List<Date> {
        // get all next dates of current month
        currentMonth = calendar[Calendar.MONTH]
        return getDates(mutableListOf())
    }


    private fun getDates(list: MutableList<Date>): List<Date> {
        // load dates of whole month
        calendar.set(Calendar.MONTH, currentMonth)
        calendar.set(Calendar.DAY_OF_MONTH, 1)
        list.add(calendar.time)
        while (currentMonth == calendar[Calendar.MONTH]) {
            calendar.add(Calendar.DATE, +1)
            if (calendar[Calendar.MONTH] == currentMonth)
                list.add(calendar.time)
        }
        calendar.add(Calendar.DATE, -1)
        return list
    }

    private fun getDates(list: MutableList<Date>, calendar: Calendar): List<Date> {
        // load dates of whole month
        list.add(calendar.time)
        while (currentMonth == calendar[Calendar.MONTH]) {
            calendar.add(Calendar.DATE, +1)
            if (calendar[Calendar.MONTH] == currentMonth)
                list.add(calendar.time)
        }
        calendar.add(Calendar.DATE, -1)
        return list
    }

    private fun setUpToolbar(title: String) {
        binding.toolbar.tvTitle.text = title
        binding.toolbar.ivUserProfile.visibility = View.VISIBLE
        binding.toolbar.ivUserProfile.setOnClickListener {
            findNavController().navigate(R.id.action_navigate_to_settingFragment)
        }
        binding.toolbar.ivBack.setOnClickListener {
            findNavController().popBackStack()
        }
    }

    private fun callAPI() {
        getSenderOrDeliverList(requestType)
        getSenderOrDeliverData()
    }

    @SuppressLint("NotifyDataSetChanged")
    private fun getSenderOrDeliverData() {
        senderDeliverViewModel.dataState.observe(this, {
            when (it) {
                is ResultState.Loading -> binding.progress.progressBar.visibility = View.VISIBLE
                is ResultState.Error -> {
                    binding.progress.progressBar.visibility = View.GONE
                    Toast.makeText(context, it.exception.message, Toast.LENGTH_SHORT).show()
                    // requireActivity().showAlert(it.exception.message!!)
                }
                is ResultState.Success -> {
                    binding.progress.progressBar.visibility = View.GONE
                    recyclerView.setBackgroundColor(resources.getColor(R.color.rv_bg_color))
                    adapterData.clear()
                    adapterData.addAll(it.data.data)
                    adapter.notifyDataSetChanged()
                }
            }
        })
    }

    private fun getSenderOrDeliverList(id: String?) {
        if (isAllValidationSuccess()) {
            resetAdapter()
            senderDeliverViewModel.getSenderOrDeliver(createApiRequest(id))
        } else {
            Toast.makeText(context, "Please enter required field", Toast.LENGTH_SHORT).show()
        }
    }

    @SuppressLint("NotifyDataSetChanged")
    private fun resetAdapter() {
        adapterData.clear()
        adapter.notifyDataSetChanged()
    }

    private fun createApiRequest(id: String?): BaseRequest {
        return GetSenderOrDeliverRequest(
            id = id,
            departure = binding.autoCompleteEditTextDeparture.text.toString(),
            destination = binding.autoCompleteEditTextDestination.text.toString(),
            date = dateValue
        )
    }

    private fun isAllValidationSuccess(): Boolean {
        return binding.autoCompleteEditTextDeparture.text.toString().isNotEmpty() &&
                binding.autoCompleteEditTextDestination.text.toString().isNotEmpty() &&
                binding.edtDate.getEditText().text.toString().isNotEmpty()
    }

    override fun onItemClick(data: SenderOrDeliver?) {
        val bundle = Bundle()
        bundle.putParcelable("data", data)
        val fragment = SenderDeliverDialogFragment()
        fragment.arguments = bundle
        fragment.show(parentFragmentManager, "Dialog");
    }

    private fun openSenderOrDeliverActivity(requestType: String) {
        val intent = Intent(context, SendOrDeliverActivity::class.java)
        intent.putExtra("request_type", requestType)
        startActivity(intent)
    }
}