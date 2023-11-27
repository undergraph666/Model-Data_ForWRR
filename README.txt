# TMForWRR
 The repository is used for the submission to WRR


GAMS Scripts
Before using these files to run the model, the user needs to replace the directory paths for the input and output files to indicate the user’s preferred location for the model and the input and output files. Each executable file below contains directory paths for the location of the input and output files that need to be updated depending on where the files are saved.

Below are the GAMS scripts to run baseline, and alternative scenarios.


• 081321_TradeModelBaselineHisonly.gms: This model is used to generate the baseline. It includes only the observed county historical crop mix. 
• 081321_TradeModel_N45_hisonly: This script reduces N runoff to the Gulf of Mexico by 10%, 20%, 30% and 45%.  
• Tariff_SB_5, Tariff_SB_10, Tariff_SB_15, Tariff_SB_20, Tariff_SB_25, Tariff_SB_30: These scripts correspond to the scenarios in which US soybean is tariffed by 5%, 10%, 15%, 20%, 25% and 30%, respectively.
• Tariff_Corn_5, Tariff_Corn_10, Tariff_Corn_15, Tariff_Corn_20, Tariff_Corn_25, Tariff_Corn_30: These scripts correspond to the scenarios in which US corn is tariffed by 5%, 10%, 15%, 20%, 25% and 30%, respectively.
• Tariff_SBCorn_5, Tariff_SBCorn_10, Tariff_SBCorn_15, Tariff_SBCorn_20, Tariff_SBCorn_25, Tariff_SBCorn_30: These scripts correspond to the scenarios in which US soybean and corn are both tariffed by 5%, 10%, 15%, 20%, 25% and 30%, respectively.

Input files and Data
The following files contain the data needed to run the model above:
• CSWMRB.csv and CSOMRB.csv contain the FIP codes of counties within and outside the Mississippi River Basin (MRB), respectively.
• hist_cropmix_2788counties_inhectare_20052019.xls: This file contains the historical crop planted acreage mix by county.
• SynCropmix_inhectare.xls: This file includes the synthetic crop acreage mix by county.
• YieldM.xls: This file contains the yield multiplier for calibration for all counties and all crops in the three watersheds.
• 2788_baseline_yieldN_fortest.xls: The file contains crop per ha yield per county, crop, and fertilizer use obtained from SWAT.
• 2788_irrigationcorn_yieldN.xls: This file contains corn yield per ha as a function of N fertilizer and irrigation levels by county.
• 2788_irrigationsb_yieldN.xls: This file contains soybean yield per ha as a function of N fertilizer and irrigation levels by county. 
• 2788_irrigationsrg_yieldN.xls: This file contains sorghum yield per ha as a function of N fertilizer and irrigation levels by county.
• irriha.xls: This file contains irrigated acres per county in the MRB.
• 2788_irrigationdepth_fortest_allF.xls: This file contains the crop optimal irrigation depth(mm) depending on per ha N fertilizer use across counties.
• FC_2788counties_2014.xls: This file contains the per ha fertilizer costs for counties outside the MRB.
• WC_2788counties_fortest_2014.xls: This file contains irrigation costs by crops and counties per ha (mean value over the years) for counties within the MRB.
• TC_noflw_2788counties_2014.xls: This file contains crop production costs excluding fertilizer, energy, and irrigation by county for all regions.
• EnergyCost2014.xls: This file contains crop production energy costs for all regions.
• DR_county.xls: This file includes delivery ratios of all counties within the MRB.
• GridCS.xls, GridCSChina.xls and GridCSROW.xls: These files contain qbar for quantity segments and ybar for consumer welfare (area under the demand) for the US, China and the rest of the world (ROW), respectively. These segments are used to linearize consumer welfare expression. We linearized the model to reduce the computational efforts/time. We used the grid linearization techniques to linearize consumer benefits (area under the demand curve), following Willett 1983 (Single‐ and Multi‐Commodity Models of Spatial Equilibrium in a Linear Programming Framework - Willett - 1983 - Canadian Journal of Agricultural Economics/Revue canadienne d'agroeconomie - Wiley Online Library). Each crop demand function is divided into 60,000 segments. qbar is the demand value for each segment, and ybar is the corresponding consumer benefit for each demand value.

Code/Software and model implementation
The model is solved using GAMSIDE build 41462 / 41464 and GAMS Release 24.1.3 r41464 WEX-WEI x86_64/MS Windows. Solutions are generated using a CPLEX solver. 


