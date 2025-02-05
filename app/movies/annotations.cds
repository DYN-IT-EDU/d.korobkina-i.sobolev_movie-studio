using MoviesService as service from '../../srv/movie-service';
using from './scenes-annotations';

annotate service.Movies with {
    title       @title: '{i18n>title}';
    releaseDate @title: '{i18n>releaseDate}';
    duration    @title: '{i18n>movieDuration}';
    movieStatus @title: '{i18n>movieStatus}';
    synopsis    @title: '{i18n>synopsis}';

};


annotate service.Movies with @(UI.HeaderInfo: {
    Title         : {
        $Type: 'UI.DataField',
        Value: title
    },
    Description   : {
        $Type: 'UI.DataField',
        Value: releaseDate
    },
    TypeName      : '{i18n>movie}',
    TypeNamePlural: '{i18n>movies}',
    TypeImageUrl  : 'sap-icon://video',
});


annotate service.Movies with @(UI: {
    Facets                : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'title',
            Target: '@UI.FieldGroup#MovieData',
            Label : '{i18n>details1}'
        },
        {

            $Type : 'UI.ReferenceFacet',
            ID    : 'title2',
            Target: '@UI.FieldGroup#MovieData2',
            Label : '{i18n>details2}'
        },
        {
            $Type : 'UI.CollectionFacet',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: 'scenes/@UI.LineItem',
            }, ]
        }
    ],


    FieldGroup #MovieData : {Data: [
        {
            $Type: 'UI.DataField',
            Value: title
        },
        {
            $Type: 'UI.DataField',
            Value: releaseDate
        },
        {
            $Type      : 'UI.DataField',
            Value      : movieStatus_code,
            Label      : '{i18n>movieStatus}',
            Criticality: criticality,
        },


    ]},

    FieldGroup #MovieData2: {Data: [
        {
            $Type: 'UI.DataField',
            Value: duration,

        },
        {
            $Type: 'UI.DataField',
            Value: synopsis,

        },
    ]}
});


annotate service.Movies with @(UI.SelectionFields: [
    title,
    releaseDate,
    duration,
    movieStatus_code,
]);


annotate service.Movies with @(Capabilities: {FilterRestrictions: {
    $Type                       : 'Capabilities.FilterRestrictionsType',
    FilterExpressionRestrictions: [

        {
            Property          : `title`,
            AllowedExpressions: 'SingleValue'
        },
        {
            Property          : 'releaseDate',
            AllowedExpressions: 'SingleRange'
        },

        {
            Property          : `movieStatus_code`,
            AllowedExpressions: 'SingleValue'
        },
    ]
}});


annotate service.Movies with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: title
    },
    {
        $Type: 'UI.DataField',
        Value: duration,

    },

    {
        $Type: 'UI.DataField',
        Value: releaseDate
    },
    {
        $Type      : 'UI.DataField',
        Value      : movieStatus_code,
        Criticality: criticality,

    },

]);
