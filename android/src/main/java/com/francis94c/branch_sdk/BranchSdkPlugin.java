package com.francis94c.branch_sdk;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import android.app.Activity;
import android.content.Context;

import org.json.JSONObject;

import java.util.Objects;

import io.branch.indexing.BranchUniversalObject;
import io.branch.referral.BranchError;
import io.branch.referral.util.BranchContentSchema;
import io.branch.referral.util.BranchEvent;
import io.branch.referral.util.CommerceEvent;
import io.branch.referral.util.ContentMetadata;
import io.branch.referral.util.CurrencyType;
import io.branch.referral.util.Product;
import io.branch.referral.util.ProductCategory;
import io.branch.referral.validators.IntegrationValidator;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.branch.referral.Branch;

/**
 * BranchSdkPlugin
 */
public class BranchSdkPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context context;
    private Activity activity;


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "branch_sdk");
        channel.setMethodCallHandler(this);

        context = flutterPluginBinding.getApplicationContext();
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            case "init":
                init(call, result);
                break;
            case "setPreinstallCampaign":
                Branch.getInstance().setPreinstallCampaign(Objects.requireNonNull(call.argument("preinstallCampaign")));
                break;
            case "setPreinstallPartner":
                Branch.getInstance().setPreinstallPartner(Objects.requireNonNull(call.argument("preInstallPartner")));
                break;
            case "validateSDKIntegration":
                IntegrationValidator.validate(context);
                break;
            case "enableLogging":
                Branch.enableLogging();
                break;
            case "setIdentity":
                if (call.hasArgument("setIdentityCallback")) {
                    Branch.getInstance().setIdentity(call.arguments(), (Branch.BranchReferralInitListener) (referringParams, error) -> {
                        result.success(error == null);
                    });
                } else {
                    Branch.getInstance().setIdentity(call.arguments());
                }
                break;
            case "logout":
                if (call.hasArgument("logoutCallback")) {
                    Branch.getInstance().logout((loggedOut, error) -> {
                        result.success(error == null);
                    });
                } else {
                    Branch.getInstance().logout();
                }
                break;
            default:
                result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        activity = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }

    private void init(MethodCall call, Result result) {
        if (call.hasArgument("debug") && call.argument("debug") != null) {
            //noinspection ConstantConditions
            if ((boolean) call.argument("debug")) {
                Branch.enableTestMode();
                Branch.enableLogging();
            }
        }
        Branch.getAutoInstance(context);
        Branch.sessionBuilder(activity).withCallback((referringParams, error) -> {
            result.success(error == null);
        }).withData(null).init();
    }
}
