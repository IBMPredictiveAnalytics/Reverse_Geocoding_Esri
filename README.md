# Reverse Geocoding ESRI
##### Code a point location (latitude, longitude) to a readable address or place name 
 
This node allows you to obtain address data from a latitude and longitude using ESRI's reverse geocoding service.     

![Diaglog](https://raw.githubusercontent.com/IBMPredictiveAnalytics/Reverse-Geocoding-Esri/master/Screenshots/dialog.png)

---
Requirements
----
-  IBM SPSS Modeler v16 or later
-  ‘R Essentials for SPSS Modeler’ plugin: [Download here][7]
-  R 2.15.x or R 3.1

---
Installation
----

1. Download the extension: [Download][3] 
2. Close IBM SPSS Modeler. Save the .cfe file in the CDB directory, located by default on Windows in "C:\ProgramData\IBM\SPSS\Modeler\16\CDB" or under your IBM SPSS Modeler installation directory.
3. Restart IBM SPSS Modeler, the node will now appear in the Field Ops palette.

---
R Packages used
----
The R packages will be installed the first time the node is used as long as an Internet connection is available.
- [plyr][4]
- [RJSONIO][9]
- [RCurl][10]
---
License
----

[Apache 2.0][1]


Contributors
----

  - Armand Ruiz ([armand_ruiz](https://twitter.com/armand_ruiz))



[1]: http://www.apache.org/licenses/LICENSE-2.0.html
[3]: https://github.com/IBMPredictiveAnalytics/Reverse-Geocoding-Esri/tree/master/Source%20code
[4]:https://cran.r-project.org/web/packages/plyr/
[7]:https://developer.ibm.com/predictiveanalytics/predictive-extensions/
[8]: https://developer.ibm.com/predictiveanalytics/downloads/
[9]: https://cran.r-project.org/web/packages/RJSONIO/
[10]: https://cran.r-project.org/web/packages/RCurl/index.html
