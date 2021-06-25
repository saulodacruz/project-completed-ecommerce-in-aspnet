var removerCSSBordaFrete;
$(() => {
    ObterUsuario();
    $('#numero').mask('0000 0000 0000 0000');
    $('#mes').mask('00');
    $('#ano').mask('00');
    $('#cvc').mask('0000');
    $('#dataNascimento').mask('00/00/0000');
    $('#cpf').mask('00000000000');
    $('input[name="CEP"]').mask('000000000');
    if (removerCSSBordaFrete != undefined && removerCSSBordaFrete) {
        $('#divFrete').removeClass('bor12');
    }
});
function CarregarCEP(cep) {
    if (cep.length > 0) {
        $.ajax({
            type: 'GET',
            url: 'https://viacep.com.br/ws/' + cep + '/json/',
            success: function (r) {
                if (JSON.stringify(r).indexOf("cep") > 0) {
                    $('input[name="Logradouro"]').val(r.logradouro);
                    $('input[name="Complemento"]').val(r.complemento);
                    $('input[name="Bairro"]').val(r.bairro);
                    $('input[name="Cidade"]').val(r.localidade);
                    $('select[name="UF"]').val(r.uf);
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}
function PopularEndereco(e) {
    $("input[name='CEP']").val(e.CEP);
    $("input[name='Logradouro']").val(e.Logradouro);
    $("input[name='Numero']").val(e.Numero);
    $("input[name='Complemento']").val(e.Complemento);
    $("input[name='Bairro']").val(e.Bairro);
    $("input[name='Cidade']").val(e.Cidade);
    $("select[name='UF']").val(e.UF);
    $('#endereco').empty();
    $('#endereco').append(e.Logradouro + ', ' + e.Numero + (e.Complemento != null && e.Complemento != '' ? ', ' + e.Complemento : '') + '<br>' + e.Bairro + ', ' + e.Cidade + '-' + e.UF + ', ' + e.CEP);
}
function SalvarEndereco() {
    $('#iconBtnSalvar').fadeIn(0);
    if (ValidarEndereco()) {
        var end = {
            CEP: $("input[name='CEP']").val().trim(),
            Logradouro: $("input[name='Logradouro']").val(),
            Numero: $("input[name='Numero']").val(),
            Complemento: $("input[name='Complemento']").val(),
            Bairro: $("input[name='Bairro']").val(),
            Cidade: $("input[name='Cidade']").val(),
            UF: $("select[name='UF']").val()
        };
        $.ajax({
            type: 'POST',
            url: '/Usuario/SalvarEnderecoCobranca',
            data: end,
            success: function (r) {
                if (r.sucesso) {
                    $('#divAlterarEndereco').fadeOut(0);
                    $('#divEndereco').fadeIn();
                    $('#iconBtnSalvar').fadeOut(0);
                    PopularEndereco(r.obj);
                    UpScroll();
                }
                else {
                    $('#iconBtnSalvar').fadeOut(0);
                    swal("Atenção", r.mensagem, "error");
                }
            },
            error: function (e) {
                swal("Atenção", "Erro ao tentar conectar-se ao servidor. Tente novamente.", "error");
                $('#iconBtnSalvar').fadeOut(0);
            }
        });
    }
    else
        $('#iconBtnSalvar').fadeOut(0);
}
function ObterUsuario() {
    $.ajax({
        type: 'GET',
        url: '/Usuario/Obter',
        success: function (r) {
            if (r.sucesso) {
                PopularEndereco(r.obj.EnderecoCobranca);
                ObterCarrinho();
            }
        }
    });
}
function ValidarEndereco() {
    var valido = true;
    var cep = $("input[name='CEP']").val().trim();
    var logradouro = $("input[name='Logradouro']").val().trim();
    var numero = $("input[name='Numero']").val().trim();
    var complemento = $("input[name='Complemento']").val().trim();
    var bairro = $("input[name='Bairro']").val().trim();
    var cidade = $("input[name='Cidade']").val().trim();
    var uf = $("select[name='UF']").val().trim();

    if (cep.length <= 0 || cep.length > 8) {
        $("input[name='CEP']").css('border', '1px solid red');
        valido = false;
    }
    else $("input[name='CEP']").css('border', '1px solid #e6e6e6');

    if (logradouro.length <= 0 || logradouro.length > 100) {
        $("input[name='Logradouro']").css('border', '1px solid red');
        valido = false;
    }
    else $("input[name='Logradouro']").css('border', '1px solid #e6e6e6');

    if (numero.length <= 0 || numero.length > 10) {
        $("input[name='Numero']").css('border', '1px solid red');
        valido = false;
    }
    else $("input[name='Numero']").css('border', '1px solid #e6e6e6');

    if (complemento.length > 50) {
        $("input[name='Complemento']").css('border', '1px solid red');
        valido = false;
    }
    else $("input[name='Complemento']").css('border', '1px solid #e6e6e6');

    if (bairro.length <= 0 || bairro.length > 45) {
        $("input[name='Bairro']").css('border', '1px solid red');
        valido = false;
    }
    else $("input[name='Bairro']").css('border', '1px solid #e6e6e6');

    if (cidade.length <= 0 || cidade.length > 32) {
        $("input[name='Cidade']").css('border', '1px solid red');
        valido = false;
    }
    else $("input[name='Cidade']").css('border', '1px solid #e6e6e6');

    if (uf == "0" || uf.length > 2 || uf.length <= 0) {
        $("select[name='UF']").css('border', '1px solid red');
        valido = false;
    }
    else $("select[name='UF']").css('border', '1px solid #e6e6e6');

    return valido;
}
function FinalizarPagamento() {
    var numero = $("#numero").val().trim(),
        cvc = $("#cvc").val().trim(),
        mes = $("#mes").val().trim(),
        ano = $("#ano").val().trim(),
        nome = $('#nome').val().trim(),
        dataNascimento = $('#dataNascimento').val().trim(),
        cpf = $('#cpf').val().trim(),
        parcelas = $('#parcelas').val(),
        codPedidoCripto = $('#codPedidoCripto').val(),
        idWirecardPedidoCripto = $('#idWirecardPedidoCripto').val();
    if (Validar()) {
        var boleto = !$('input[name="formaPagamento"]')[0].checked;
        if (boleto)
            PagarBoleto();
        else
            PagarCartao();
    }
    else
        UpScroll();
    function PagarBoleto() {
        $('#iconBtnFinalizar').fadeIn(0);
        var pagamento = {
            CodPedidoCripto: codPedidoCripto,
            IdWirecardPedidoCripto: idWirecardPedidoCripto,
            Boleto: true
        }
        $.ajax({
            type: 'POST',
            url: '/Pagamento/Finalizar',
            data: pagamento,
            success: function (r) {
                if (r.sucesso)
                    window.location.href = `/Pedido/${r.obj.CodPedido}`;
                else {
                    swal("Atenção", r.mensagem, "error");
                    $('#iconBtnFinalizar').fadeOut(0);
                }
            },
            error: function (e) {
                $('#iconBtnFinalizar').fadeOut(0);
                swal("Atenção", "Erro ao tentar conectar-se ao servidor. Tente novamente.", "error");
            }
        })
    }
    function PagarCartao() {
        $('#iconBtnFinalizar').fadeIn(0);
        var cc = new Moip.CreditCard({
            number: numero,
            cvc: cvc,
            expMonth: mes,
            expYear: ano,
            pubKey: atob($("#public_key").val())
        });
        if (cc.isValid()) {
            var pagamento = {
                Nome: nome,
                CPF: cpf,
                DataNascimento: dataNascimento,
                Parcelas: parcelas,
                Hash: cc.hash().toString(),
                CodPedidoCripto: codPedidoCripto,
                IdWirecardPedidoCripto: idWirecardPedidoCripto,
                Boleto: false
            }
            $.ajax({
                type: 'POST',
                url: '/Pagamento/Finalizar',
                data: pagamento,
                success: function (r) {
                    if (r.sucesso)
                        window.location.href = `/Pedido/${r.obj.CodPedido}`;
                    else {
                        $('#iconBtnFinalizar').fadeOut(0);
                        swal("Atenção", r.mensagem, "error");
                    }
                },
                error: function (e) {
                    $('#iconBtnFinalizar').fadeOut(0);
                    swal("Atenção", "Erro ao tentar conectar-se ao servidor. Tente novamente.", "error");
                }
            })
        }
        else {
            $('#iconBtnFinalizar').fadeOut(0);
            swal('Atenção', 'Dados do cartão de crédito incorretos.', 'error');
        }
    }
    function Validar() {
        if (!$('input[name="formaPagamento"]')[0].checked)
            return true;
        else {
            var retorno = true;
            if (nome.length <= 0) {
                retorno = false;
                $("#nome").css('border', '1px solid red');
            }
            else $("#nome").css('border', '1px solid #e6e6e6');

            if (numero.length < 10) {
                retorno = false;
                $("#numero").css('border', '1px solid red');
            }
            else $("#numero").css('border', '1px solid #e6e6e6');

            if (cvc.length <= 0) {
                retorno = false;
                $("#cvc").css('border', '1px solid red');
            }
            else $("#cvc").css('border', '1px solid #e6e6e6');

            if (mes.length <= 0) {
                retorno = false;
                $("#mes").css('border', '1px solid red');
            }
            else $("#mes").css('border', '1px solid #e6e6e6');

            if (ano.length <= 0) {
                retorno = false;
                $("#ano").css('border', '1px solid red');
            }
            else $("#ano").css('border', '1px solid #e6e6e6');

            if (parseInt(parcelas) <= 0) {
                retorno = false;
                $("#parcelas").css('border', '1px solid red');
            }
            else $("#parcelas").css('border', '1px solid #e6e6e6');

            if (!ValidarData(dataNascimento)) {
                retorno = false;
                $("#dataNascimento").css('border', '1px solid red');
            }
            else $("#dataNascimento").css('border', '1px solid #e6e6e6');

            if (!ValidarCPF(cpf)) {
                retorno = false;
                $("#cpf").css('border', '1px solid red');
            }
            else $("#cpf").css('border', '1px solid #e6e6e6');

            return retorno;
        }
    }
}
function ValidarData(data) {
    if (data == undefined || data.length < 10)
        return false;
    var d = data.substr(0, 2);
    var m = data.substr(3, 2);
    var y = data.substr(6, 4);
    if (d > 31 || d <= 0 || m > 12 || m <= 0 || y < 1850)
        return false;
    return true;
}
function ValidarCPF(strCPF) {
    if (strCPF < 14)
        return false
    strCPF = strCPF.replace('.', '').replace('.', '').replace('-', '');
    var Soma;
    var Resto;
    Soma = 0;
    if (strCPF == "00000000000") return false;

    for (i = 1; i <= 9; i++) Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (11 - i);
    Resto = (Soma * 10) % 11;

    if ((Resto == 10) || (Resto == 11)) Resto = 0;
    if (Resto != parseInt(strCPF.substring(9, 10))) return false;

    Soma = 0;
    for (i = 1; i <= 10; i++) Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (12 - i);
    Resto = (Soma * 10) % 11;

    if ((Resto == 10) || (Resto == 11)) Resto = 0;
    if (Resto != parseInt(strCPF.substring(10, 11))) return false;
    return true;
}