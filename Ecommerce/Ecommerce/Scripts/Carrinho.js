var produtosLeveTambemCarregados = false;
var ftg = false;
$(() => {
    LoaderTr(true);
    ObterEndereco();
    $('input[name="CEP"]').mask('000000000');
});
function LoaderTr(abrir) {
    if (abrir) {
        $('.tableRow').fadeOut(0);
        $('.loaderTrCarrinho').remove();
        $('#itensPedidos').append('<td colspan="5" class="loaderTrCarrinho" style="border-top: 1px solid #e6e6e6;height: 130px;"><div class="lds-ellipsis" id="loaderDivProdutosA" style="width: 80px;height: 80px;position: relative;left: 50%;right: 50%;top: 50%;z-index: 100000000;transform: translate(-50%,-50%);"><div></div><div></div><div></div><div></div></div></td>')
    }
    else {
        $('.loaderTrCarrinho').remove();
        $('.tableRow').fadeIn();
    }
}
function CarregarCarrinho() {
    LoaderTr(true);
    $.ajax({
        type: 'GET',
        url: '/Pedidos/ObterCarrinhoFrete',
        success: function (r) {
            if (r.sucesso) {
                if (r.obj.Carrinho.length <= 0) {
                    $('#divCarrinho').empty();
                    $('#divCarrinho').append("<div style='width:100%;padding:20px; text-align:center'>Carrinho vazio :(</div>");
                    CarregarLeveTambem();
                    return;
                }
                var valorTotal = 0;
                var subTotal = 0;
                r.obj.Carrinho.forEach(function (item, i) {
                    valorTotal += (item.valor * item.qtd);
                    subTotal += (item.valor * item.qtd);
                    item.valor = item.valor.toString().replace('.', ',');
                });
                if ($('#codCupom').val().length > 0 && $('#valorCupom').val().length > 0) {
                    valorTotal = valorTotal - parseFloat($('#valorCupom').val().replace(',', '.'));
                    $('#divFrete').removeClass('bor12');
                    $('#divDesconto').fadeIn();
                    $('#desconto').text($('#valorCupom').val().replace('.', ','));
                }

                if (r.obj.Frete.SEDEX != null) {
                    $('#btnSEDEX')[0].checked = true;
                    $('#frete').text(r.obj.Frete.SEDEX.price.replace('.', ','));
                    $('#trSEDEX').fadeIn(0);
                    $('#valorSEDEX').text(r.obj.Frete.SEDEX.price.replace('.', ','));
                    $('#qtdDiasSEDEX').text(r.obj.Frete.SEDEX.delivery_time);
                    $('#valFreteSEDEXCrip').val(r.obj.Frete.SEDEXValor);
                    $('#valPrazoSEDEXCrip').val(r.obj.Frete.SEDEXPrazo);
                    if (!r.obj.FreteGratis)
                        valorTotal += parseFloat(r.obj.Frete.SEDEX.price.replace(',', '.'));
                }
                else $('#trSEDEX').fadeOut(0);

                if (r.obj.Frete.PAC != null) {
                    $('#trPAC').fadeIn(0);
                    $('#valorPAC').text(r.obj.Frete.PAC.price.replace('.', ','));
                    $('#qtdDiasPAC').text(r.obj.Frete.PAC.delivery_time);
                    $('#valFretePACCrip').val(r.obj.Frete.PACValor);
                    $('#valPrazoPACCrip').val(r.obj.Frete.PACPrazo);
                    if (r.obj.Frete.SEDEX == null) {
                        $('#btnPAC')[0].checked = true;
                        $('#frete').text(r.obj.Frete.PAC.price.replace('.', ','));
                        if (!r.obj.FreteGratis)
                            valorTotal += parseFloat(r.obj.Frete.PAC.price.replace(',', '.'));
                    }
                }
                else $('#trPAC').fadeOut(0);

                $('#total').text(valorTotal.toFixed(2).replace('.', ','));
                $('#subTotal').text(subTotal.toFixed(2).replace('.', ','));

                localStorage.setItem('aioCar', JSON.stringify({ offUser: false, car: r.obj.Carrinho }));
                CarregarTrs(r.obj.Carrinho);
                ftg = r.obj.FreteGratis;

                if (ftg) {
                    $('.divFrete').fadeOut(0);
                    $('#simbRS').fadeOut(0);
                    $('#frete').text('GRÁTIS').css('color', 'green');
                }
                else {
                    $('#frete').css('color', '#333');
                    $('#simbRS').fadeIn(0);
                    $('.divFrete').fadeIn(0);
                }
            }
            else
                swal("Atenção", r.mensagem, "error");

            LoadCar();
            CarregarLeveTambem();
        },
        error: function (e) {
            swal("Atenção", "Erro ao tentar conectar-se ao servidor. Tente novamente.", "error");
            LoadCar();
            LoaderTr(false);
        }
    });
    function CarregarTrs(obj) {
        $('.tableRow').remove();
        obj.forEach(function (item, i) {
            item.valor = parseFloat(item.valor.toString().replace(',', '.')).toFixed(2).replace('.', ',');
            var tr =
                `<tr class="tableRow">
                                <td style="padding: 15px 14px 15px 19px;">
                                    <a href="${item.url}"><img src="${item.urlImg}" alt="${item.nome}" title="${item.nome}" style="width: 90px;"></a>
                                </td>
                                <td style="text-align: left; cursor:pointer" onclick="window.location.href = '${item.url}'" title="${item.nome}">${item.nome}<br/><small style="color: #717fe0;display: block;">${item.obs}</small></td>
                                <td style="padding: 0 7px;">R$ ${item.valor}</td>
                                <td>
                                    <div class="wrap-num-product flex-w m-l-auto m-r-0 tdItemQtd">
                                        <div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m" onclick="RemoverCar(${item.cod}, '${item.obs}', true)" title="Remover">
                                            <i class="fs-16 zmdi zmdi-minus"></i>
                                        </div>
                                        <input class="mtext-104 cl3 txt-center num-product" type="number" name="num-product1" value="${item.qtd}" readonly="true">
                                        <div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m" onclick="AddCar(${item.cod}, '${item.nome}', '${item.valor}', 1, '${item.urlImg}', '${item.url}', '${item.obs}', true)" title="Adicionar">
                                            <i class="fs-16 zmdi zmdi-plus"></i>
                                        </div>
                                    </div>
                                </td>
                                <td style="padding: 0 7px;">R$ ${(parseFloat(item.valor.replace(',', '.')) * item.qtd).toFixed(2).replace('.', ',')}</td>
                            </tr>`;
            $('#itensPedidos').append(tr);
        });
        LoaderTr(false);
    }
}
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
function ValidarCad2() {
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
    if (ValidarCad2()) {
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
            url: '/Usuario/SalvarEndereco',
            data: end,
            success: function (r) {
                if (r.sucesso) {
                    $('#divAlterarEndereco').fadeOut(0);
                    $('#divEndereco').fadeIn();
                    $('#iconBtnSalvar').fadeOut(0);
                    PopularEndereco(r.obj);
                    UpScroll();
                    CarregarCarrinho();
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
function ObterEndereco() {
    $.ajax({
        type: 'GET',
        url: '/Usuario/ObterEndereco',
        success: function (r) {
            if (r.sucesso) {
                PopularEndereco(r.obj);
                CarregarCarrinho();
            }
        }
    });
}
function AplicarCupom() {
    var codigo = $('input[name="cupom"]').val().trim();
    if (codigo.length <= 0 || codigo.length > 50) {
        $("input[name='cupom']").css('border', '1px solid red');
        return;
    }
    else
        $("input[name='cupom']").css('border', '1px solid #e6e6e6');
    $.ajax({
        type: 'GET',
        url: '/Pedidos/ObterCupom',
        data: { codigo },
        success: function (r) {
            if (r.sucesso) {
                $('#codCupom').val(r.obj.CodCupom);
                $('#valorCupom').val(r.obj.Valor);
                CarregarCarrinho();
                swal("Cupom Aplicado", "O desconto foi adicionado.", "success");
            }
            else
                swal("Atenção", r.mensagem, "error");
        },
        error: function (e) {
            swal("Atenção", "Erro ao tentar conectar-se ao servidor. Tente novamente.", "error");
        }
    });
}
function Cadastrar() {
    $('#iconBtnFinalizar').fadeIn(0);
    var valorFrete = $('#btnSEDEX')[0].checked ? $('#valFreteSEDEXCrip').val() : $('#valFretePACCrip').val();
    var prazo = $('#btnSEDEX')[0].checked ? $('#valPrazoSEDEXCrip').val() : $('#valPrazoPACCrip').val();
    $.ajax({
        type: 'POST',
        url: '/Pedidos/Cadastrar',
        data: {
            p: { CodCupom: $('#codCupom').val() == '' ? 0 : $('#codCupom').val(), ValorFrete: ftg ? 0 : valorFrete, TipoFrete: ftg ? 'A DECIDIR' : $('#btnSEDEX')[0].checked ? 'SEDEX' : 'PAC' },
            valorFreteCrip: ftg ? 0 : valorFrete,
            diasFreteCrip: prazo
        },
        success: function (r) {
            if (r.sucesso)
                window.location.href = '/Pagamento/Pedido/' + r.obj.CodPedido;
            else {
                swal("Atenção", r.mensagem, "error");
                $('#iconBtnFinalizar').fadeOut(0);
            }
        },
        error: function (e) {
            swal("Atenção", "Erro ao tentar conectar-se ao servidor. Tente novamente.", "error");
            $('#iconBtnFinalizar').fadeOut(0);
        }
    });
}
function ChangeFrete() {
    var valorFrete = $('#btnSEDEX')[0].checked ? parseFloat($('#valorSEDEX').text().replace(',', '.')) : parseFloat($('#valorPAC').text().replace(',', '.'));
    var valorTotal = parseFloat($('#total').text().replace(',', '.'));
    valorTotal -= parseFloat($('#frete').text().replace(',', '.'));
    valorTotal += valorFrete;
    $('#frete').text(valorFrete.toFixed(2).replace('.', ','))
    $('#total').text(valorTotal.toFixed(2).replace('.', ','));
}
function CarregarLeveTambem() {
    if (!produtosLeveTambemCarregados) {
        CarregarProdutos('Leve também', 'divProdutos', 24, 'loaderDivProdutos');
        produtosLeveTambemCarregados = true;
    }
}