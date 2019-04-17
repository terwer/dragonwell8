![Dragonwell Logo](https://raw.githubusercontent.com/wiki/alibaba/dragonwell8/images/dragonwell_std_txt_horiz.png)

[Alibaba Dragonwell8 User Guide](https://github.com/alibaba/dragonwell8/wiki/Alibaba-Dragonwell8-User-Guide)

[Alibaba Dragonwell8 Release Notes](https://github.com/alibaba/dragonwell8/wiki/Alibaba-Dragonwell8-Release-Notes)

# Introduction

Over the years, Java has proliferated in Alibaba. Many applications are written in Java and many our Java developers have written more than one billion lines of Java code.

Alibaba Dragonwell, as a downstream version of OpenJDK, is the in-house OpenJDK implementation at Alibaba optimized for online e-commerce, financial, logistics applications running on 100,000+ servers. Alibaba Dragonwell is the engine that runs these distributed Java applications in extreme scaling.

Alibaba Dragonwell is certified as compatible with the Java SE standard. The current release supports Linux/x86_64 platform only.

Alibaba Dragonwell is clearly a "friendly fork" under the same licensing terms as the upstream OpenJDK project. Alibaba is committed to collaborate closely with OpenJDK community and intends to bring as many customized features as possible from Alibaba Dragonwell to the upstream.

# Using Alibaba Dragonwell

Alibaba Dragonwell JDK currently supports Linux/x86_64 platform only.

### Installation

* Option 1, Download and install pre-built Alibaba Dragonwell
   * You may download a pre-built Alibaba Dragonwell JDK from its GitHub page:
https://github.com/alibaba/dragonwell8/releases.
   * Uncompress the package to the installation directory.

* Option 2, Install via YUM
(will be available soon)
> Supports RedHat, CentOS, and AliOS only.
   * Add Aliyun's RPM repository to your /etc/repos.d/.
   * Install Alibaba Dragonwell using YUM:
`yum install dragonwell-8`

### Enable Alibaba Dragonwell for Java applications

To enable Alibaba Dragonwell JDK for your application, simply set JAVA_HOME to point to the installation directory of Alibaba Dragonwell.

# Get Source and setup env


1.download dragonwell8 with

```
wget https://terwer.oss-cn-qingdao.aliyuncs.com/github/dragonwell8.tar.gz
```

or

```
git clone https://github.com/terwer/dragonwell8.git
cd dragonwell8
./get_source_terwer.sh
```

2.download jdk7 and put to `/opt/java/jdk1.7.0_80` as BootJDK

```
wget https://terwer.oss-cn-qingdao.aliyuncs.com/soft/jdk/jdk-7u80-linux-x64.tar.gz
```

3.Install fedora 29

http://www.terwergreen.com/post-dark/7871.html


# Build your Own JDK

```
sudo ./make.sh
```

# Acknowledgement

Special thanks to those who have made contributions to Alibaba's internal JDK builds.

# Publications

Technologies included in Alibaba Dragonwell have been published in following papers

* ICSE'19：https://2019.icse-conferences.org/event/icse-2019-technical-papers-safecheck-safety-enhancement-of-java-unsafe-api

* ICPE'18: https://dl.acm.org/citation.cfm?id=3186295

* ICSE'18 SEIP  https://www.icse2018.org/event/icse-2018-software-engineering-in-practice-java-performance-troubleshooting-and-optimization-at-alibaba
