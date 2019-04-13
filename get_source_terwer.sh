git clone https://github.com/terwer/dragonwell8_jdk.git jdk --depth 1
cd jdk
git fetch --unshallow
cd ../
git clone https://github.com/terwer/dragonwell8_hotspot.git hotspot --depth 1
cd hotspot
git fetch --unshallow
cd ../
git clone https://github.com/alibaba/dragonwell8_corba.git corba --depth 1
cd corba
git fetch --unshallow
cd ../
git clone https://github.com/alibaba/dragonwell8_langtools.git langtools --depth 1
cd langtools
git fetch --unshallow
cd ../
git clone https://github.com/alibaba/dragonwell8_nashorn.git nashorn --depth 1
cd nashorn
git fetch --unshallow
cd ../
git clone https://github.com/alibaba/dragonwell8_jaxp.git jaxp --depth 1
cd jaxp
git fetch --unshallow
cd ../
git clone https://github.com/alibaba/dragonwell8_jaxws.git jaxws --depth 1
cd jaxws
git fetch --unshallow
cd ../
echo "success."
