using SceneService from '../../srv/scene-service';
annotate SceneService.Scenes with {
    movie @title : '{i18n>Movieid}';
    description @title : '{i18n>Description}';
    duration @title : '{i18n>Duration}';
    status @title : '{i18n>Status}';
    ID @title : '{i18n>Sceneid}';
};

annotate SceneService.Scenes with @(
    UI.Identification : [  
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'SceneService.changeStatusToPending',
            Label: 'Change to pending',
        }
    ],
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
                Value : movie_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Value : duration,
            },
            {
                $Type : 'UI.DataField',
                Value : status,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>SceneInfoFacet}',
            ID : 'SceneInfoFacet',
            Target : '@UI.FieldGroup#SceneInfoGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>ExpensesInfo}',
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

annotate SceneService.Expenses with {
    category    @title: '{i18n>Categoryid}';
    
    expense     {
        amount      @title: '{i18n>Amount}';
        currency    @title: '{i18n>Currency}';
    };
    expenseDate @title: '{i18n>ExpenseDate}';
    description @title: '{i18n>Description}';
}


annotate SceneService.Expenses with @(
    UI.LineItem #ExpensesInfo : [
        {
            $Type : 'UI.DataField',
            Value : category_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : expense_amount,
        },
        {
            $Type : 'UI.DataField',
            Value : expense_currency_code,
        },
        {
            $Type : 'UI.DataField',
            Value : expenseDate,
        },
        {
            $Type : 'UI.DataField',
            Value : description,
        },
    ]
);

