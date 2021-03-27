@@ -0,0 +1,156 @@
package com.fazconapps.file_sharing_appp

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    private fun signInWithPhoneAuthCredential(credential: PhoneAuthCredential) {
        MethodChannel(flutterEngine.dartExecutor,"flutter/firebaseTokenDemo").setMethodCallHandler{
            call,result ->
            if (call.method=="firebase"){
                var token = null

                auth?.signInWithCredential(credential)
                        ?.addOnCompleteListener(this) { task ->
                            if (task.isSuccessful) {
                                // Sign in success, update UI with the signed-in user's information
                                val mUser = auth!!.currentUser
                                mUser!!.getIdToken(true)
                                        .addOnCompleteListener { task ->
                                            if (task.isSuccessful) {
                                                idToken = task.result!!.token.toString()
                                                PreferenceSetting.setLoginToken(this, idToken)
                                                val federatedSignInOptions = FederatedSignInOptions.builder()
                                                        .cognitoIdentityId(identityId)
                                                        .customRoleARN("arn:aws:iam::547956940052:oidc-provider/securetoken.google.com/backupapp-b2820")
                                                        .build()
                                                // login with identity pool
                                                val mobileClient = Amplify.Auth.getPlugin("awsCognitoAuthPlugin").escapeHatch as AWSMobileClient?
                                                // mobileClient?.currentUserState()
                                                mobileClient?.federatedSignIn("securetoken.google.com/backupappnew-8f97f", idToken,
                                                        object : Callback<UserStateDetails?> {
                                                            override fun onError(e: Exception?) {
                                                                customProgressDialog.dialog.dismiss()
                                                                Utils.getToastMessage(
                                                                        this@OtpVerificationActivity,
                                                                        Constant.SOMETHING_WRONG
                                                                )
                                                                Log.e("TAG", "sign-in error", e)
                                                            }
                                                            @SuppressLint("StringFormatInvalid")
                                                            @RequiresApi(Build.VERSION_CODES.N)
                                                            override fun onResult(result: UserStateDetails?) {
                                                                Log.e("TAG", "Result: " + result)
                                                                // get token of Firebase messaging service
                                                                FirebaseMessaging.getInstance().token.addOnCompleteListener(
                                                                        OnCompleteListener { task ->
                                                                            if (!task.isSuccessful) {
                                                                                Log.w(
                                                                                        TAG,
                                                                                        "Fetching FCM registration token failed",
                                                                                        task.exception
                                                                                )
                                                                                return@OnCompleteListener
                                                                            }
                                                                            // Get new FCM registration token
                                                                            val token = task.result
                                                                            PreferenceSetting.setFcmToken(
                                                                                    baseContext,
                                                                                    token!!
                                                                            )
                                                                            Utils.getToastMessage(
                                                                                    this@OtpVerificationActivity, getString(
                                                                                    R.string.msg_token_fmt
                                                                            )
                                                                            )
                                                                        })
                                                                customProgressDialog.dialog.dismiss()
                                                                Amplify.API.query(
                                                                        ModelQuery.list(
                                                                                Users::class.java, Users.PHONE.contains(
                                                                                PreferenceSetting.getMobileNumber(
                                                                                        this@OtpVerificationActivity
                                                                                )
                                                                        )
                                                                        ),
                                                                        { response ->
                                                                            if ((response.data.items as ArrayList).size > 0) {
                                                                                PreferenceSetting.setUserId(
                                                                                        this@OtpVerificationActivity,
                                                                                        (response.data.items as ArrayList).get(
                                                                                                0
                                                                                        ).id
                                                                                )
                                                                                PreferenceSetting.setMobileNumber(
                                                                                        this@OtpVerificationActivity,
                                                                                        (response.data.items as ArrayList).get(
                                                                                                0
                                                                                        ).phone
                                                                                )
                                                                                PreferenceSetting.setUserAvatar(
                                                                                        this@OtpVerificationActivity,
                                                                                        (response.data.items as ArrayList).get(
                                                                                                0
                                                                                        ).profilepicture
                                                                                )
                                                                                PreferenceSetting.setUserName(
                                                                                        this@OtpVerificationActivity,
                                                                                        (response.data.items as ArrayList).get(
                                                                                                0
                                                                                        ).username
                                                                                )
                                                                                val intent = Intent(
                                                                                        this@OtpVerificationActivity,
                                                                                        MainActivity::class.java
                                                                                )
                                                                                intent.flags =
                                                                                        Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
                                                                                startActivity(intent)
                                                                            } else {
                                                                                val intent = Intent(
                                                                                        this@OtpVerificationActivity,
                                                                                        UserProfileActivity::class.java
                                                                                )
                                                                                intent.flags =
                                                                                        Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
                                                                                startActivity(intent)
                                                                            }
                                                                        },
                                                                        { error ->
                                                                            Log.e(
                                                                                    "MyAmplifyApp",
                                                                                    "Query failure",
                                                                                    error
                                                                            )
                                                                        }
                                                                )
                                                            }
                                                        })
                                            } else {
                                                customProgressDialog.dialog.dismiss()
                                                Utils.getToastMessage(
                                                        this@OtpVerificationActivity,
                                                        Constant.SOMETHING_WRONG
                                                )
                                                //Handle error -> task.getException();
                                            }
                                            Log.d(TAG, "signInWithCredential:success")
                                        }
                                val user = task.result?.user
                            } else {
                                customProgressDialog.dialog.dismiss()
                                // Sign in failed, display a message and update the UI
                                // Utils.getToastMessage(this@OtpVerificationActivity, "signIn failure")
                                Log.w(TAG, "signInWithCredential:failure", task.exception)
                                if (task.exception is FirebaseAuthInvalidCredentialsException) {
                                    Utils.getToastMessage(
                                            this@OtpVerificationActivity,
                                            "Verification code entered was invalid"
                                    )
                                    // The verification code entered was invalid
                                    // [START_EXCLUDE silent]
                                    //  binding.fieldVerificationCode.error = "Invalid code."
                                    // [END_EXCLUDE]
                                }
                                // [START_EXCLUDE silent]
                                // Update UI
                                // updateUI(STATE_SIGNIN_FAILED)
                                // [END_EXCLUDE]
                            }
                        }
            }

                if (imgs.size <= 0) {
                    result.error("Error", null);
                } else {
                    result.success(token);
                }

            }
        }

}