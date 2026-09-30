# Aturan ProGuard/R8 tambahan untuk build release PosyTrace.
# File ini sengaja minimal: aturan bawaan Android ("proguard-android-optimize.txt")
# dan consumer-rules dari tiap plugin Flutter sudah menutupi kebutuhan umum.
# Jika setelah minify ada crash ClassNotFoundException/NoSuchMethodError,
# tambahkan -keep spesifik untuk kelas yang hilang di bawah baris ini.
