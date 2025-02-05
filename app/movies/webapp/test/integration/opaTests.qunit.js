sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/movies/test/integration/FirstJourney',
		'ns/movies/test/integration/pages/MoviesList',
		'ns/movies/test/integration/pages/MoviesObjectPage',
		'ns/movies/test/integration/pages/ScenesObjectPage'
    ],
    function(JourneyRunner, opaJourney, MoviesList, MoviesObjectPage, ScenesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/movies') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheMoviesList: MoviesList,
					onTheMoviesObjectPage: MoviesObjectPage,
					onTheScenesObjectPage: ScenesObjectPage
                }
            },
            opaJourney.run
        );
    }
);