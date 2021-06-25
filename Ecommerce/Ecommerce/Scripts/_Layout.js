function CarregarBotoes() {
    if (getCookie("aiopcod") != null) {
        $('#btnSairD').fadeIn(0);
        $('#btnSairM').fadeIn(0);
    }
    else {
        $('#btnSairD').fadeOut(0);
        $('#btnSairM').fadeOut(0);
    }
}
function Loader(abrir) { if (abrir) { $('#dvBody').fadeOut(); $('.lds-ellipsis').fadeIn(); } else { $('.lds-ellipsis').fadeOut(); $('#dvBody').fadeIn(); } }
function createCookie(name, value, days) { var expires; if (days) { var date = new Date(); date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000)); expires = "; expires=" + date.toGMTString(); } else { expires = ""; } document.cookie = encodeURIComponent(name) + "=" + encodeURIComponent(value) + expires + "; path=/"; }
function getCookie(name) { var value = "; " + document.cookie; var parts = value.split("; " + name + "="); if (parts.length == 2) return parts.pop().split(";").shift(); }
function removeCookie(name) {
    var date = new Date();
    date.setTime(date.getTime() + (-1 * 24 * 60 * 60 * 1000));
    var expires = "; expires=" + date.toGMTString();
    document.cookie = name + "=" + '' + expires + "; path=/";
}
function CarregarRegras() {
    if (getCookie('aiopSessaoLogin') == null ||
        getCookie('aiopcod') == null ||
        getCookie('aiopemail') == null ||
        getCookie('aiopnome') == null) {
        removeCookie('aiopSessaoLogin');
        removeCookie('aiopcod');
        removeCookie('aiopemail');
        removeCookie('aiopnome');
    }
    if (getCookie('aiopcod') == null) {
        if (localStorage.getItem('aioCar') != null) {
            var aioCar = JSON.parse(localStorage.getItem('aioCar'));
            if (!aioCar.offUser) {
                localStorage.removeItem('aioCar');
                LoadCar();
            }
        }
        if (localStorage.getItem('aioDes') != null) {
            var aioDes = JSON.parse(localStorage.getItem('aioDes'));
            if (!aioDes.offUser) {
                localStorage.removeItem('aioDes');
                LoadDes();
            }
        }
    }
    else {
        if (getCookie('aiopnome') != null)
            $('.spanNomeTop').text('Olá ' + getCookie('aiopnome'));

        if (getCookie('aioploadingUser') == null && localStorage.getItem('aioCar') == null)
            ObterCarrinho();
        else if (getCookie('aioploadingUser') != null)
            CarregarCarrinhoUsuario();
    }

    var verficarUrlCar = window.location.href.replace('//', '');
    if (localStorage.getItem('goToCart') != null && verficarUrlCar.substr(verficarUrlCar.indexOf('/') + 1).indexOf('Usuario/Login') != 0 && verficarUrlCar.substr(verficarUrlCar.indexOf('/') + 1).indexOf('Usuario/Cadastro'))
        localStorage.removeItem('goToCart');
}
function CarregarProdutos(nome, idDiv, codsCategoria, idDivLoad) {
    $.ajax({
        type: 'GET',
        url: '/Home/ObterProdutosPorCat?codsCategoria=' + codsCategoria + '&nome=' + nome,
        success: function (r) {
            $('#' + idDiv).html(r);
            $('#' + idDivLoad).fadeOut(0);
        },
        error: function (e) {
            $('#' + idDivLoad).fadeOut(0);
        }
    });
}
function ConvertDateToDataLocal(data) {
    dia = data.getDate().toString(),
        diaF = (dia.length == 1) ? '0' + dia : dia,
        mes = (data.getMonth() + 1).toString(),
        mesF = (mes.length == 1) ? '0' + mes : mes,
        anoF = data.getFullYear();
    return diaF + "/" + mesF + "/" + anoF;
}
function FinalizarCompraOfCarrinho() {
    localStorage.setItem('goToCart', 'on');
    window.location.href = '/Carrinho';
}
function UpScroll() {
    $('html,body').animate({ scrollTop: 0 }, 300);
}
function BuscarCategoria() {
    var text = $('#buscarCategoria').val().trim().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
    if (text.length > 0) {
        $.ajax({
            type: 'GET',
            url: `/Home/BuscarCategoria?texto=${text}`,
            success: function (r) {
                if (r.sucesso) {
                    $('#divPesquisaCats').empty();
                    if (r.obj.length > 0) {
                        r.obj.forEach(function (item, i) {
                            $('#divPesquisaCats').append(`<div class="itemPesquisaCat"><a href="/Produtos/${item.Nome}">${item.Descricao}</a></div>`);
                        });
                    }
                    else {
                        $('#divPesquisaCats').empty();
                        $('#divPesquisaCats').append(`<div class="itemPesquisaCat"><a style="cursor:auto">Nenhum resultado encontrado!</a></div>`);
                    }
                }
                else {
                    $('#divPesquisaCats').empty();
                    $('#divPesquisaCats').append(`<div class="itemPesquisaCat"><a style="cursor:auto">Nenhum resultado encontrado!</a></div>`);
                }
            }
        });
    }
    else {
        $('#divPesquisaCats').empty();
        $('#divPesquisaCats').append(`<div class="itemPesquisaCat"><a style="cursor:auto">Nenhum resultado encontrado!</a></div>`);
    }
}
function CadEmail() {
    $('#btnEmailAssinatura').fadeIn(0);
    var email = $('#txtEmailAssinatura').val().trim();
    if (validateEmail(email)) {
        $('#inputEmailAssinatura').css('border-bottom', '2px solid rgba(204, 204, 204, 0.66)');
        $.ajax({
            type: 'GET',
            url: `/Usuario/AssinarEmail?email=${email}`,
            success: function (r) {
                if (r.sucesso) {
                    swal("E-mail cadastrado com sucesso", "Em breve você receberá novidades ;)", "success")
                }
                else {
                    swal("Atenção", r.mensagem, "error");
                }
                $('#btnEmailAssinatura').fadeOut(0);
            },
            error: function (e) {
                $('#btnEmailAssinatura').fadeOut(0);
                swal("Atenção", "Erro ao tentar conectar-se ao servidor. Tente novamente.", "error");
            }
        });
    }
    else {
        $('#inputEmailAssinatura').css('border-bottom', '2px solid rgba(255, 7, 7, 0.66)');
        $('#btnEmailAssinatura').fadeOut(0);
    }
    function validateEmail(email) {
        var re = /^(([^<>()[\]\\.,;:\s@@\"]+(\.[^<>()[\]\\.,;:\s@@\"]+)*)|(\".+\"))@@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }
}
$('.parallax100').parallax100();
$(() => {
    LoadCar();
    LoadDes();
    CarregarRegras();
    CarregarBotoes();
});
window.onload = function () {
    if (imgsErrors)
        window.location.reload();
};