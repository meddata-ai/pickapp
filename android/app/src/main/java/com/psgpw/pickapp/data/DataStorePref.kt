package com.psgpw.pickapp.data

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import com.psgpw.pickapp.data.models.User
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

val Context.dataStore: DataStore<Preferences> by preferencesDataStore(
    name = "pickApp"
)

//abstract class DataStoreService(open val context: Context) {
//
//
//    abstract suspend fun saveUserToPreferencesStore(user: User)
//
//    abstract fun getUserFromPreferencesStore(): Flow<User>
//
//    abstract fun getUserApiKey(): Flow<String>
//}
class DataStoreManager(val context: Context) {

    private val USER_API_KEY = stringPreferencesKey("user_api_key")

    private val USER_LOGIN_STATUS = booleanPreferencesKey("login_status")
    private val NOTIFICATION_ACCOUNT_VIEW = booleanPreferencesKey("account_view")
    private val NOTIFICATION_CONTACT_VIEW = booleanPreferencesKey("contact_view")
    private val NOTIFICATION_SYSTEM_VIEW = booleanPreferencesKey("system_view")

    private val USER_NAME = stringPreferencesKey("user_name")
    private val USER_ID = stringPreferencesKey("user_id")
    private val USER_EMAIL = stringPreferencesKey("user_email")
    private val USER_PHONE = stringPreferencesKey("user_phone")
    private val USER_IMAGE = stringPreferencesKey("user_image")

    private val REQUEST_EMAIL = stringPreferencesKey("request_email")
    private val REQUEST_PHONE = stringPreferencesKey("request_phone")

    //private val USER_ID = stringPreferencesKey("user_id")

    suspend fun saveUserToPreferencesStore(user: User) {
        context.dataStore.edit { preferences ->
            preferences[USER_API_KEY] = user.apikey ?: ""
            preferences[USER_NAME] = user.name
            preferences[USER_ID] = user.id
            preferences[USER_EMAIL] = user.email
            preferences[USER_PHONE] = user.phone ?: ""
            preferences[USER_IMAGE] = user.image
            preferences[USER_LOGIN_STATUS] = true
            preferences[REQUEST_EMAIL] = user.email
            preferences[REQUEST_PHONE] = user.phone ?: ""
        }
    }

    fun getUserFromPreferencesStore(): Flow<User> = context.dataStore.data
        .map { preferences ->
            User(
                id = preferences[USER_ID] ?: "",
                apikey = preferences[USER_API_KEY] ?: "",
                name = preferences[USER_NAME] ?: "",
                email = preferences[USER_EMAIL] ?: "",
                image = preferences[USER_IMAGE] ?: "",
                phone = preferences[USER_PHONE] ?: "",
            )
        }

    fun getUserApiKey(): Flow<String> =
        context.dataStore.data.map { preferences ->
            preferences[USER_API_KEY] ?: ""
        }

    fun getUserImage(): Flow<String> =
        context.dataStore.data.map { preferences ->
            preferences[USER_IMAGE] ?: ""
        }


    suspend fun setUserImage(image: String) =
        context.dataStore.edit { preferences ->
            preferences[USER_IMAGE] = image
        }

    suspend fun setUserName(name: String) =
        context.dataStore.edit { preferences ->
            preferences[USER_NAME] = name
        }

    suspend fun setUserPhone(phone: String) =
        context.dataStore.edit { preferences ->
            preferences[USER_PHONE] = phone
        }


    fun getRequestPhone(): Flow<String> =
        context.dataStore.data.map { preferences ->
            preferences[USER_PHONE] ?: ""
        }

    suspend fun setPhoneNumberForSenderOrDeliverRequest(phone: String) =
        context.dataStore.edit { preferences ->
            preferences[REQUEST_PHONE] = phone
        }

    fun getRequestEmail(): Flow<String> =
        context.dataStore.data.map { preferences ->
            preferences[REQUEST_EMAIL] ?: ""
        }

    suspend fun setEmailForSenderOrDeliverRequest(email: String) =
        context.dataStore.edit { preferences ->
            preferences[REQUEST_EMAIL] = email
        }

    suspend fun setNotificationAccountView(isChecked: Boolean) =
        context.dataStore.edit { preferences ->
            preferences[NOTIFICATION_ACCOUNT_VIEW] = isChecked
        }

    suspend fun setNotificationContactView(isChecked: Boolean) =
        context.dataStore.edit { preferences ->
            preferences[NOTIFICATION_CONTACT_VIEW] = isChecked
        }

    suspend fun setNotificationSystemView(isChecked: Boolean) =
        context.dataStore.edit { preferences ->
            preferences[NOTIFICATION_SYSTEM_VIEW] = isChecked
        }

    fun getNotificationAccountView(): Flow<Boolean> =
        context.dataStore.data.map {
            it[NOTIFICATION_ACCOUNT_VIEW] ?: true
        }

    fun getNotificationContactView(): Flow<Boolean> =
        context.dataStore.data.map {
            it[NOTIFICATION_CONTACT_VIEW] ?: true
        }


    fun getNotificationSystemView(): Flow<Boolean> =
        context.dataStore.data.map {
            it[NOTIFICATION_SYSTEM_VIEW] ?: true
        }


    fun isUserLogin(): Flow<Boolean> =
        context.dataStore.data.map {
            it[USER_LOGIN_STATUS] ?: false
        }

    suspend fun userLogout() {
        context.dataStore.edit { preferences ->
            preferences[USER_LOGIN_STATUS] = false
        }
    }
}