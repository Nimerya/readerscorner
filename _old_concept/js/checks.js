
$().ready(function () {
    //Aggiunge * ai label degli input aventi classe "mandatory"
   
    $('.mandatory')
            .parent()
            .children(':first-child')
            .append(" *");
    //Nascondo il div di errore
    $('div.errors').hide();


    //su click del pulante di login resetto il box di errore
    $('button.login').click(function () {
        $('div.errors').hide();
        $('div.errors').html('<b>There are some errors:<b><br><br>');
        //per ogni campo di login oblligatorio controllo che non sia vuoto e se lo è aggiungo l'errore e rendo il div visibile
        $('.mlogin').each(function () {
            if ($(this).val() == "") {
                $('div.errors').show();
                $('div.errors').append('&nbsp&nbsp&nbsp&nbsp- fill the <b>"' + $(this)
                        .parent()
                        .children(':first-child')
                        .html()
                        .slice(0, -2) + '"</b> field<br>');
            };
        });
    });

    //stessa cosa di sopra ma per la parte di registrazione
    $('button.register').click(function () {
        
        $('div.errors').hide();
        $('div.errors').html('<b>There are some errors:<b><br><br>');
        
        //check campi password e conferma password
        if ($('input.pw').val() != $('input.cpw').val() ) {
            $('div.errors').show();
            $('div.errors').append('&nbsp&nbsp&nbsp&nbsp- password mismatch<br>');
        }
        
        $('.mregister').each(function () {
            if ($(this).val() == "") {
                $('div.errors').show();
                $('div.errors').append('&nbsp&nbsp&nbsp&nbsp- fill the <b>"' + $(this)
                        .parent()
                        .children(':first-child')
                        .html()
                        .slice(0, -2) + '"</b> field<br>');
            };
        });
        
    });


});


