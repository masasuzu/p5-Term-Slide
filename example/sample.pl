[
    +{
        title => "タイトル",
        contents => [
            +{ content => '* nで次へ、pで前へ', },
            +{ content => "* ansii color使えるよ。\e[31m赤いよ。超赤いよ\e[0m", wait => 1 },
            +{ content => "* \e[33m黄色\e[0mとか", wait => 1 },
            +{ content => '* wait => 1とかすると、waitもかけられるよ', },
        ],
    },
    +{
        contents => [
            +{ content => '* タイトルなしもできるよ', },
            +{ content => "* \e[31mほげ\e[0m", },
            +{ content => '* ほげ', },
            +{ content => '  * ほほげ', wait => 1 },
            +{ content => '  * ほほげ', },
        ],
    },
    +{
        title => "タイトル",
        contents => [
            +{ content => "* \e[31mほげ\e[0m", },
            +{ content => '* ほげ', },
            +{ content => '  * ほほほげ', },
            +{ content => '  * ほげ', },
            +{ content => '* ほげ', },
        ],
    },
];
