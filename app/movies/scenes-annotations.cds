using MoviesService as service from '../../srv/movie-service';


annotate service.Scenes with {
    description @title: '{i18n>description}';
    duration    @title: '{i18n>duration}';
    status      @title: '{i18n>movieStatus}';
    expenses    @title: '{i18n>expenses}';

};

annotate service.Scenes with @(UI.HeaderInfo: {
    Title         : {
        $Type: 'UI.DataField',
        Value: description
    },
    TypeName      : '{i18n>scene}',
    TypeNamePlural: '{i18n>scenes}',
    TypeImageUrl  : 'sap-icon://video',

});


annotate service.Scenes with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: description

    },
    {
        $Type: 'UI.DataField',
        Value: duration

    },
    {
        $Type: 'UI.DataField',
        Value: status

    },

]);

annotate service.Scenes with @(UI: {
    Identification        : [{Value: movie_ID},

    ],
    Facets                : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#SceneData2',
        Label : '{i18n>sceneEnhancedDetails}',
    },

    ],
    FieldGroup #SceneData2: {Data: [
        {
            $Type: 'UI.DataField',
            Value: description
        },
        {
            $Type: 'UI.DataField',
            Value: duration
        }
    ]


    },
});
