sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/scenesweb/test/integration/FirstJourney',
		'ns/scenesweb/test/integration/pages/ScenesList',
		'ns/scenesweb/test/integration/pages/ScenesObjectPage',
		'ns/scenesweb/test/integration/pages/ExpensesObjectPage'
    ],
    function(JourneyRunner, opaJourney, ScenesList, ScenesObjectPage, ExpensesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/scenesweb') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheScenesList: ScenesList,
					onTheScenesObjectPage: ScenesObjectPage,
					onTheExpensesObjectPage: ExpensesObjectPage
                }
            },
            opaJourney.run
        );
    }
);