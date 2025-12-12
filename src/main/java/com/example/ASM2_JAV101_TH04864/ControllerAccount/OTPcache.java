package com.example.ASM2_JAV101_TH04864.ControllerAccount;

import java.util.HashMap;
import java.util.Map;

public class OTPcache {
    private static final Map<String, OTPData> cache = new HashMap<>();

    public static void store(String email, String otp) {
        cache.put(email, new OTPData(otp, System.currentTimeMillis() + 180000));
    }

    public static boolean verify(String email, String otp) {
        OTPData data = cache.get(email);
        if (data == null) return false;
        if (System.currentTimeMillis() > data.expireTime) {
            cache.remove(email);
            return false;
        }
        boolean ok = data.otp.equals(otp);
        if (ok) cache.remove(email);
        return ok;
    }

    private static class OTPData {
        String otp;
        long expireTime;
        OTPData(String otp, long expireTime) {
            this.otp = otp;
            this.expireTime = expireTime;
        }
    }
}
