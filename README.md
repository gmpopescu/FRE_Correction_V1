# FRE_Correction_V1
Shiny app for the correction of freshwater reservoir of 14C dates, in contexts where the maximum FRE of the region is known.

The Carbon-14 in freshwater reservoirs (such as lakes, rivers, and wetlands) may have a different concentration of Carbon-14 compared to the atmosphere. This is because the Carbon-14 in the reservoirs comes from a combination of atmospheric Carbon-14 and Carbon-14 from the decay of organic matter within the reservoirs. As a result, organisms that live in or near freshwater reservoirs may have a different Carbon-14 concentration than organisms that live in the open ocean or on land.

In the case of human bone samples, if the individual consumed freshwater fish or other aquatic organisms, the carbon-14 in the bone would reflect the lower carbon-14 concentration in the freshwater reservoir, rather than the atmospheric concentration. This can lead to inaccuracies in radiocarbon dating, as the age of the bone may appear older than it actually is. The magnitude of the effect depends on the location and age of the freshwater reservoir, as well as the specific diet of the individual (Cook et al. 2001; Cook et al. 2002; Lanting and Van Der Plicht 1998; Philippsen 2013).

The code provided here defines a shiny app with a UI and server component.
This app's purpose is to help user correct the freshwater reservoir effect of radiocarbon dates when the maximum (FRE) of the region is known.

All the details relative to the calculations performed to obtain the corrected radiocarbon dates, as well as the variables neded, have been explained at length in several recent publications (Cook et al. 2015; García-Vázquez et al. 2023; Sayle et al. 2014; Sayle et al. 2016; Stratton et al. 2019).

The UI component contains input widgets for the maximum FRE of the region, the maximum FRE standard deviation, the 14C date standard deviation, the percentage of aquatic resource in the diet, and its standard deviation. 
The server component, of the application, calculates the FRE offset, FRE offset sd, the corrected date and standard deviation, and generates the output plot and table based on user input. After the user clicks on the “Calculate” button, the app will perform the FRE correction using the formulas written below and will display the corrected radiocarbon date in a table and a plot.
To run the app, save the code as a  .R file and run it in RStudio or any R environment that supports Shiny applications.

All the above calculations are performed by the server component of the application and are based on several equations/formulas taken from Sayle et al. (2016; see also García-Vázquez et al. 2023), as follows:
1. For freshwater correction: FWcorrection = %Freshwater.diet * Maximum.FRE.
2. For freshwater correction sd: FWcorr/sd = (%Frshwater.dietsd / %Freshwater.diet) x FWcorrection.
3. For corrected 14C: 14Ccorrected = 14C – FWcorrection.
4. For corrected 14C sd: sqrt[(14Csd)^2 + (FWcorr/sd)^2].

A csv file from Vazquez et al. (2023) is also provided to exemplify app’s use.
The application is free to use, and the source code is also freely available for further customization and improvement, as the user contexts and research questions require.

References

Cook GT, Ascough PL, Bonsall C, Hamilton WD, Russell N, Sayle KL, Scott EM, Bownes JM. 2015. Best practice methodology for 14C calibration of marine and mixed terrestrial/marine samples. Quaternary Geochronology. 27:164–171. doi:10.1016/j.quageo.2015.02.024. 

Cook GT, Bonsall C, Hedges RE, McSweeney K, Boronean V, Pettitt PB. 2001. A freshwater diet-derived 14 C reservoir effect at the Stone Age sites in the Iron Gates gorge. Radiocarbon. 43(2A):453–460.

Cook GT, Bonsall C, Hedges RE, McSweeney K, Boroneant V, Bartosiewicz L, Pettitt PB. 2002. Problems of dating human bones from the Iron Gates. Antiquity. 76(291):77–85.

García-Vázquez A, Bălășescu A, Vasile G, Golea M, Radu V, Opriș V, Ignat Th, Culea M, Covătaru C, Sava G, et al. 2023. Entanglements of the terrestrial-aquatic mixed diet: a stable isotopes perspective on the Chalcolithic human population from Gumelnița site (Romania). Scientific Reports.

Lanting JN, Van Der Plicht J. 1998. Reservoir Effects and Apparent Ages. The Journal of Irish Archaeology.:151–165.

Philippsen B. 2013. The freshwater reservoir effect in radiocarbon dating. herit sci. 1(1):24. doi:10.1186/2050-7445-1-24.

Sayle KL, Cook GT, Ascough PL, Gestsdóttir H, Hamilton WD, McGovern TH. 2014. Utilization of δ13C, δ15N, and δ34S Analyses to Understand 14C Dating Anomalies within a Late Viking Age Community in Northeast Iceland. Radiocarbon. 56(2):811–821. doi:10.2458/56.17770. 

Sayle KL, Hamilton WD, Gestsdóttir H, Cook GT. 2016. Modelling Lake Mývatn’s freshwater reservoir effect: Utilisation of the statistical program FRUITS to assist in the re-interpretation of radiocarbon dates from a cemetery at Hofstaðir, north-east Iceland. Quaternary Geochronology. 36:1–11. doi:10.1016/j.quageo.2016.07.001.

Stratton S, Griffiths S, Kogălniceanu R, Simalcsik A, Morintz A, Ştefan CE, Dumitraşcu V, Ramsey CB, Nehlich O, Beavan N, et al. 2019. The Emergence of Extramural Cemeteries in Neolithic Southeast Europe: A Formally Modeled Chronology for Cernica, Romania. Radiocarbon. 61(1):319–346. doi:10.1017/RDC.2018.34.
