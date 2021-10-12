<?php
return [
    'path' => base_path() . '/app/Modules',
    'base_namespace' => 'App\Modules',
    'groupWithoutPrefix' => 'Pub',

    'groupMidleware' => [
        'Admin' => [
            'web' => ['auth'],
        'api' => ['auth:api'],
        ]
    ],

    'modules' => [
        'Admin' => [
           'Unit',
           'TaskComment',
           'Task',
           'TaskComment',
           'Task',
           'Analitics',
           'Analitics',
           'LeadComment',
           'Lead',
           'Sources',
           'Role',
           'Menu',
           'Dashboard',
           'User',
           'Unit',
           'Status',
        ],

        'Pub' => [
            'Auth',
            'Analitics',
        ],
    ]
];