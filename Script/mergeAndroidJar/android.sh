jar -xvf android1.jar
jar -xvf core-libart_intermediates.jar
jar -xvf core-oj_intermediates.jar
jar -xvf framework_intermediates.jar
jar -xvf framework-res.rar
jar -xvf telephony-common.jar
rm -rf *.jar
rm -rf *.rar
jar -cvfM android.jar .
