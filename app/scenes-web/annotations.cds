using SceneService from '../../srv/scene-service';
annotate SceneService.Scenes with @(
    UI.Identification : [  
    //     {
    //         $Type : 'UI.DataFieldForAction',
    //         Action: 'SceneService.EntityContainer/createScene',
    //         Label: 'create',
    //     },
            {
            $Type : 'UI.DataFieldForAction',
            Action: 'SceneService.calculateScenesExpenses',
            Label: 'Calculate expenses',
        }
    ],

    // UI.Identification : [
    //     {
    //         $Type : 'UI.DataFieldForAction',
    //         Action: 'SceneService.calculateScenesExpenses',
    //         Label: 'Calculate expenses',
    //     }
    // ],
    UI.HeaderInfo                : {
        TypeName      : 'Scene',
        TypeNamePlural: 'Scenes',
        Description   : {
            Value: description,
            Label: 'Description',
        }
    },
    UI.SelectionFields           : [
        movie_ID,
        status,
    ],
    UI.FieldGroup #SceneInfoGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Movieid}',
                Value : movie_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Description}',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Duration}',
                Value : duration,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Status}',
                Value : status,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information of scene',
            ID : 'SceneInfoFacet',
            Target : '@UI.FieldGroup#SceneInfoGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Expenses Info',
            ID : 'ExpensesInfo',
            Target : 'expenses/@UI.LineItem#ExpensesInfo',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Movieid}',
            Value : movie_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Description}',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Duration}',
            Value : duration,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Status}',
            Value : status,
            Criticality : status,
            CriticalityRepresentation : #WithIcon,
            ![@UI.Importance] : #High,
        },
    ],
);
annotate SceneService.Expenses with @(
    UI.LineItem #ExpensesInfo : [
        {
            $Type : 'UI.DataField',
            Value : category_ID,
            Label : 'category_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : expense_amount,
            Label : 'expense_amount',
        },
        {
            $Type : 'UI.DataField',
            Value : expense_currency_code,
            Label : 'expense_currency_code',
        },
        {
            $Type : 'UI.DataField',
            Value : expenseDate,
            Label : 'expenseDate',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'description',
        },
    ]
);

