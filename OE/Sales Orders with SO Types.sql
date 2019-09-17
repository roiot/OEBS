select oh.header_id, oh.order_number, tt.name as order_type, oh.ordered_date --oh.*
from OE_ORDER_HEADERS_ALL oh,
     OE_TRANSACTION_TYPES_TL tt
where oh.order_type_id = tt.transaction_type_id
and tt.language = 'US' 
and oh.org_id = 5557
--and oh.ordered_date between to_date('01.07.2019', 'DD.MM.YYYY') and to_date('31.07.2019', 'DD.MM.YYYY')
and oh.order_number in (
324888,
327261,
327262,
327263,
327265,
327266,
327272,
327274,
327319,
327321,
327326,
327341,
327343,
327347,
327354,
327359,
327362,
327365,
327366,
327370,
327371,
327372,
327375,
327378,
327379,
327424,
327425,
327427,
327428,
327430,
327433,
327435,
327436,
327438,
327441,
327442,
327443,
327444,
327447,
327448,
327473,
327477,
327483,
327485,
327491,
327501,
327997,
327999,
328001,
328405,
328406,
328407,
328479,
328482,
328485,
328494,
328498,
328500,
328502,
328508,
328509,
328517,
328519,
328520,
328521,
328524,
328525,
328527,
328528,
328529,
328540,
329087,
329088,
329089,
329090,
329095,
329100,
329110,
329121,
329136,
329137,
329139,
329140,
329141,
329142,
329143,
329180,
329261,
329341,
329354,
329379,
329412,
329430,
330408,
330413,
330414,
330415,
330416,
330417,
330418,
330421,
330422,
330423,
330424,
330425,
330426,
330427,
330428,
330429,
330430,
330431,
330432,
330433,
330434,
330435,
330436,
330437,
330438,
330439,
330440,
330635,
330869,
330872,
330878,
330902,
330904,
330909,
330912,
330913,
330914,
330915,
330916,
330917,
330918,
330964,
331291,
331295,
331296,
331297,
331299,
331300,
331304,
331305,
331308,
331309,
331311,
331312,
331313,
331314,
331315,
331316,
331317,
331323,
331324,
331325,
331326,
331327,
331328,
331329,
331330,
331333,
331334,
331336,
331337,
331339,
331340,
331341,
331343,
331344,
331346,
331349,
331350,
331351,
331352,
331353,
331357,
331384,
331385,
331387,
331388,
331390,
331391,
331392,
331393,
331394,
331395,
331396,
331397,
331398,
331399,
331400,
331401,
331402,
331403,
331404,
331405,
331406,
331407,
331408,
331409,
331410,
331411,
331412,
331413,
331414,
331415,
331416,
331417,
331418,
331419,
331420,
331421,
331422,
331423,
331424,
331425,
331434,
331455,
331461,
331464,
331465,
331466,
331467,
331468,
331470,
331508,
331510,
331526,
331555,
331566,
331575,
331576,
331578,
331580,
331581,
331582,
331585,
331586,
331588,
331589,
331590,
331598,
331599,
331600,
331601,
331679,
331700,
331703,
331710,
331713,
331714,
331717,
331722,
331726,
331731,
331733,
331735,
331736,
331737,
331738,
331739,
331740,
331741,
331742,
331743,
331744,
331746,
331747,
331748,
331749,
331750,
331751,
331752,
331753,
331754,
331755,
331756,
331757,
331758,
331759,
331760,
331761,
331762,
331763,
331764,
331765,
331766,
331770,
332087,
333508,
333516)
order by oh.order_number;