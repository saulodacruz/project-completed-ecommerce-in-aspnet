function OpenCar() {    
    var aioCar = localStorage.getItem('aioCar');
    $('#titleCart').text('Seu Carrinho');
    $('#aioCar').empty();
    if (aioCar == null) {
        $('#aioCar').append('Carrinho vazio :(');
        $('.comItem').fadeOut(0);
    }
    else {
        aioCar = JSON.parse(aioCar);
        if (aioCar.car.length == 0) {
            $('#aioCar').append('Carrinho vazio :(');
            $('.comItem').fadeOut(0);
        }
        var valorTotal = 0;
        aioCar.car.forEach(function (item, i) {
            $('#aioCar').append(
                `<li class="header-cart-item flex-w flex-t m-b-12">
                    <div class="header-cart-item-img-edited">
                    <a href="${item.url}"><img src="${item.urlImg}" width="70" style="margin-top: 5px;" alt="${item.nome}"></a>
                    </div>
                    <div class="header-cart-item-txt p-t-8" style="padding-top:0;width:calc(89% - 80px)">
                        <a href="${item.url}" class="header-cart-item-name m-b-18 hov-cl1 trans-04" title="${item.nome}">
                            ${item.nome}
                        </a>
                        <span class="header-cart-item-info">
                            ${item.qtd}x R$ ${parseFloat(item.valor.toString().replace(',', '.')).toFixed(2)}
                        </span>
                        <small>${item.obs}</small>
                    </div>
                    <div class="removeItemCard">
                        <span onclick="RemoverCar(${item.cod}, '${item.obs}')" style="color:red;cursor:pointer" title="Remover">X</span>
                    </div>
                </li>`
            );
            valorTotal += item.qtd * parseFloat(item.valor.replace(',', '.'));
        });
        if (aioCar.car.length > 0)
            $('.comItem').fadeIn(0);
        else
            $('.comItem').fadeOut(0);

        $('#txtCartTotal').text(valorTotal.toFixed(2).indexOf('.') == -1 ? valorTotal + ',00' : valorTotal.toFixed(2).replace('.', ','));
    }
}
function LoadCar() {
    var aioCar = localStorage.getItem('aioCar');
    var count = 0;
    if (aioCar == null)
        $('.btnCarrinho').attr('data-notify', count);
    else {
        aioCar = JSON.parse(aioCar);
        aioCar.car.forEach(function (item, i) {
            count += item.qtd;
        });
        $('.btnCarrinho').attr('data-notify', count);
    }
    $(document).on('cartAio', function () {
        if (!$('#cartAio').hasClass('show-header-cart'))
            setTimeout(function () { $('#aioCar').empty(); }, 200);
    });
}
function AddCar(cod, nome, valor, qtd, urlImg, url, obs = ' ', addQtdTelaCarrinho = false, funcaoComprar = false) {
    if (getCookie('aiopcod') == null)
        AddCarLocal();
    else
        AddCarDB();

    function AddCarLocal() {
        if (cod != null && nome != null && valor != null && qtd != null && urlImg != null && url != null) {
            if (qtd <= 0) return;
            var aioCar = localStorage.getItem('aioCar');
            if (aioCar == null)
                localStorage.setItem('aioCar', JSON.stringify({ offUser: true, car: [{ cod, nome, valor, qtd, urlImg, url, obs }] }));
            else {
                aioCar = JSON.parse(aioCar);
                var done = false;
                aioCar.car.forEach(function (item, i) {
                    if (item.cod == cod && item.obs == obs && !done) {
                        aioCar.car[i].qtd += qtd;
                        localStorage.setItem('aioCar', JSON.stringify(aioCar));
                        done = true;
                    }
                });
                if (!done) {
                    aioCar.car.push({ cod, nome, valor, qtd, urlImg, url, obs });
                    localStorage.setItem('aioCar', JSON.stringify(aioCar));
                }
            }
            LoadCar();
            if (funcaoComprar)
                FinalizarCompraOfCarrinho();
            else
                swal(nome, "Foi adicionado ao Carrinho.", "success");
        }
        else
            swal("Atenção", "Erro ao adicionar item no Carrinho. Tente novamente.", "error");
    }
    function AddCarDB()
    {
        if (cod != null && nome != null && valor != null && qtd != null && urlImg != null && url != null)
        {
            if (qtd <= 0) return;
            if (addQtdTelaCarrinho)
                LoaderTr(true);
            var aioCar = localStorage.getItem('aioCar');
            if (aioCar == null)
            {
                $.ajax({
                    type: 'POST',
                    url: '/Pedidos/AdicionarItemCarrinho',
                    data: { item: { cod, nome, valor, qtd, urlImg, url, obs }, update: false },
                    success: function (r) {
                        if (r.sucesso) {
                            localStorage.setItem('aioCar', JSON.stringify({ offUser: false, car: [{ cod, nome, valor, qtd, urlImg, url, obs }] }));
                            LoadCar();
                            if (addQtdTelaCarrinho)
                                CarregarCarrinho();
                            else {
                                if (funcaoComprar)
                                    FinalizarCompraOfCarrinho();
                                else
                                    swal(nome, "Foi adicionado ao Carrinho.", "success");
                            }
                        }
                        else {
                            if (addQtdTelaCarrinho)
                                LoaderTr(false);
                            swal("Atenção", r.mensagem, "error");
                        }
                    },
                    error: function (e) {
                        LoadCar();
                        if (addQtdTelaCarrinho)
                            LoaderTr(false);
                        swal("Atenção", "Erro ao adicionar item no Carrinho. Tente novamente.", "error");
                    }
                });
            }
            else {
                aioCar = JSON.parse(aioCar);
                var done = false;
                aioCar.car.forEach(function (item, i) {
                    if (item.cod == cod && item.obs == obs && !done) {
                        aioCar.car[i].qtd += qtd;
                        $.ajax({
                            type: 'POST',
                            url: '/Pedidos/AdicionarItemCarrinho',
                            data: { item: aioCar.car[i], update: true },
                            success: function (r) {
                                if (r.sucesso) {
                                    localStorage.setItem('aioCar', JSON.stringify(aioCar));
                                    LoadCar();
                                    if (addQtdTelaCarrinho)
                                        CarregarCarrinho();
                                    else {
                                        if (funcaoComprar)
                                            FinalizarCompraOfCarrinho();
                                        else
                                            swal(nome, "Foi adicionado ao Carrinho.", "success");
                                    }
                                }
                                else {
                                    if (addQtdTelaCarrinho)
                                        LoaderTr(false);
                                    swal("Atenção", r.mensagem, "error");
                                }
                            },
                            error: function (e) {
                                LoadCar();
                                if (addQtdTelaCarrinho)
                                    LoaderTr(false);
                                swal("Atenção", "Erro ao adicionar item no Carrinho. Tente novamente.", "error");
                            }
                        });
                        done = true;
                    }
                });
                if (!done) {
                    $.ajax({
                        type: 'POST',
                        url: '/Pedidos/AdicionarItemCarrinho',
                        data: { item: { cod, nome, valor, qtd, urlImg, url, obs }, update: false },
                        success: function (r) {
                            if (r.sucesso) {
                                aioCar.car.push({ cod, nome, valor, qtd, urlImg, url, obs });
                                localStorage.setItem('aioCar', JSON.stringify(aioCar));
                                LoadCar();
                                if (addQtdTelaCarrinho)
                                    CarregarCarrinho();
                                else {
                                    if (funcaoComprar)
                                        FinalizarCompraOfCarrinho();
                                    else
                                        swal(nome, "Foi adicionado ao Carrinho.", "success");
                                }
                            }
                            else {
                                if (addQtdTelaCarrinho)
                                    LoaderTr(false);
                                swal("Atenção", r.mensagem, "error");
                            }
                        },
                        error: function (e) {
                            LoadCar();
                            if (addQtdTelaCarrinho)
                                LoaderTr(false);
                            swal("Atenção", "Erro ao adicionar item no Carrinho. Tente novamente.", "error");
                        }
                    });
                }
            }
        }
        else {
            if (addQtdTelaCarrinho)
                LoaderTr(false);
            swal("Atenção", "Erro ao adicionar item no Carrinho. Tente novamente.", "error");
        }
    }
}
function RemoverCar(cod, obs = ' ', removeQtdTelaCarrinho = false){
    if (cod != undefined) {
        if (cod > 0) {
            if (getCookie('aiopcod') == null)
                RemoverCarLocal();
            else
                RemoverCarDB();

            function RemoverCarLocal() {
                var aioCar = JSON.parse(localStorage.getItem('aioCar'));
                var done = false;
                aioCar.car.forEach(function (item, i) {
                    if (item.cod == cod && item.obs == obs && !done) {
                        aioCar.car[i].qtd -= 1;
                        if (aioCar.car[i].qtd == 0)
                            aioCar.car.splice(i, 1);
                        if (aioCar.car.length == 0)
                            localStorage.removeItem('aioCar');
                        else
                            localStorage.setItem('aioCar', JSON.stringify(aioCar));
                        OpenCar();
                        LoadCar();
                        done = true;
                    }
                });
            }
            function RemoverCarDB()
            {
                if (removeQtdTelaCarrinho)
                    LoaderTr(true);
                var aioCar = JSON.parse(localStorage.getItem('aioCar'));
                var done = false;
                aioCar.car.forEach(function (item, i) {
                    if (item.cod == cod && item.obs == obs && !done) {
                        $.ajax({
                            type: 'POST',
                            url: '/Pedidos/RemoverItemCarrinho',
                            data: { item: { cod, obs, qtd: aioCar.car[i].qtd } },
                            success: function (r) {
                                if (r.sucesso) {
                                    aioCar.car[i].qtd -= 1;
                                    if (aioCar.car[i].qtd <= 0)
                                        aioCar.car.splice(i, 1);
                                    if (aioCar.car.length == 0)
                                        localStorage.removeItem('aioCar');
                                    else
                                        localStorage.setItem('aioCar', JSON.stringify(aioCar));
                                    OpenCar();
                                    LoadCar();
                                    if (removeQtdTelaCarrinho)
                                        CarregarCarrinho();
                                }
                                else {
                                    if (removeQtdTelaCarrinho)
                                        LoaderTr(false);
                                    swal("Atenção", r.mensagem, "error");
                                }
                            },
                            error: function (e) {
                                LoadCar();
                                OpenCar();
                                if (removeQtdTelaCarrinho)
                                    LoaderTr(false);
                                swal("Atenção", "Erro ao remover o item do Carrinho. Tente novamente.", "error");
                            }
                        });
                        done = true;
                    }
                });
            }
        }
    }
}
function CarregarCarrinhoUsuario() {
    var aioCar = localStorage.getItem('aioCar');
    var aioDes = localStorage.getItem('aioDes');
    if (aioCar != null)
    {
        aioCar = JSON.parse(aioCar);
        if (aioCar.offUser) {
            $.ajax({
                type: 'POST',
                url: '/Pedidos/AtualizarCarrinho',
                data: { itens: aioCar.car },
                success: function (r) {
                    if (r.sucesso) {
                        r.obj.forEach(function (item, i) {
                            item.valor = item.valor.toString().replace('.', ',');
                        });
                        localStorage.setItem('aioCar', JSON.stringify({ offUser: false, car: r.obj }));
                        removeCookie('aioploadingUser');
                        CarregarListaDesejoUsuario();
                    }
                    LoadCar();
                },
                error: function (e) {
                    LoadCar();
                }
            });
        }
        else if (aioDes != null)
            CarregarListaDesejoUsuario();
    }
    else if (aioDes != null)
        CarregarListaDesejoUsuario();
    else
        ObterCarrinho();
}
function ObterCarrinho() {
    $.ajax({
        type: 'GET',
        url: '/Pedidos/ObterCarrinho',
        success: function (r) {
            if (r.sucesso) {
                r.obj.forEach(function (item, i) {
                    item.valor = item.valor.toString().replace('.', ',');
                });
                localStorage.setItem('aioCar', JSON.stringify({ offUser: false, car: r.obj }));
                ObterListaDesejo();
                removeCookie('aioploadingUser');
            }
            LoadCar();
            if (localStorage.getItem('goToCart') != null)
                window.location.href = '/Carrinho';
        },
        error: function (e) {
            LoadCar();
        }
    });
}

function OpenDes() {
    var aioDes = localStorage.getItem('aioDes');
    $('#titleCart').text('Lista de Desejos');
    $('.comItem').fadeOut(0);
    $('#aioCar').empty();
    if (aioDes == null) {
        $('#aioCar').append('Lista de desejos vazia :(');
    }
    else {
        aioDes = JSON.parse(aioDes);
        if (aioDes.des.length == 0) {
            $('#aioCar').append('Lista de desejos vazia :(');
            $('.comItem').fadeOut(0);
        }
        aioDes.des.forEach(function (item, i) {
            $('#aioCar').append(
                '<li class="header-cart-item flex-w flex-t m-b-12">'
                + '    <div class="header-cart-item-img-edited">'
                + '    <a href="' + item.url + '"><img src="' + item.urlImg + '" width="70" style="margin-top: 5px;"></a>'
                + '    </div>'
                + '    <div class="header-cart-item-txt p-t-8" style="padding-top:0;width:calc(89% - 80px)">'
                + '        <a href="' + item.url + '" class="header-cart-item-name m-b-18 hov-cl1 trans-04" style="display: initial !important;">'
                + '            ' + item.nome
                + '        </a>'
                + '        <span class="header-cart-item-info">'
                + '            R$ ' + parseFloat(item.valor.toString().replace(',', '.')).toFixed(2)
                + '        </span>'
                + '    </div>'
                + '    <div class="removeItemCard">'
                + '        <span onclick="RemoverDes(' + item.cod + ')" style="color:red;cursor:pointer">X</span>'
                + '    </div>'
                + '</li>'
            );
        });
    }
}
function LoadDes() {
    var aioDes = localStorage.getItem('aioDes');
    var count = 0;
    $('.onIcon').css('opacity', '0');
    if (aioDes == null)
        $('.btnDesejo').attr('data-notify', count);
    else {
        aioDes = JSON.parse(aioDes);
        aioDes.des.forEach(function (item, i) {
            count++;
            ActiveIconDes(item.cod, true);
        });
        $('.btnDesejo').attr('data-notify', count);
    }
    $(document).on('cartAio', function () {
        if (!$('#cartAio').hasClass('show-header-cart'))
            setTimeout(function () { $('#aioCar').empty(); }, 200);
    });
}
function AddDes(cod, nome, valor, qtd, urlImg, url) {
    if (getCookie('aiopcod') == null)
        AddDesLocal(cod, nome, valor, qtd, urlImg, url);
    else
        AddDesDB(cod, nome, valor, qtd, urlImg, url);

    function AddDesLocal(cod, nome, valor, qtd, urlImg, url) {
        if (cod != null && nome != null && valor != null && qtd != null && urlImg != null && url != null) {
            if ($('.iconDes_' + cod).hasClass('desOn')) {
                ActiveIconDes(cod, false);
                RemoverDes(cod);
            }
            else {
                ActiveIconDes(cod, true);
                if (qtd <= 0) return;
                var aioDes = localStorage.getItem('aioDes');
                if (aioDes == null) {
                    localStorage.setItem('aioDes', JSON.stringify({ offUser: true, des: [{ cod, nome, valor, qtd, urlImg, url }] }));
                    swal(nome, "Foi adicionado em sua lista de desejos.", "success");
                }
                else {
                    var done = false;
                    aioDes = JSON.parse(aioDes);
                    aioDes.des.forEach(function (item, i) {
                        if (item.cod == cod) {
                            done = true;
                            swal(nome, "Já está adicionado em sua lista de desejos.", "success");
                        }
                    });
                    if (!done) {
                        aioDes.des.push({ cod, nome, valor, qtd, urlImg, url });
                        localStorage.setItem('aioDes', JSON.stringify(aioDes));
                        swal(nome, "Foi adicionado em sua lista de desejos.", "success");
                    }
                }
                LoadDes();
            }
        }
        else
            swal("Atenção", "Erro ao adicionar em sua lista de desejos. Tente novamente.", "error");
    }
    function AddDesDB(cod, nome, valor, qtd, urlImg, url) {
        if (cod != null && nome != null && valor != null && qtd != null && urlImg != null && url != null) {
            if ($('.iconDes_' + cod).hasClass('desOn'))
                RemoverDes(cod);
            else {
                if (qtd <= 0) return;
                var aioDes = localStorage.getItem('aioDes');
                if (aioDes == null) {
                    $.ajax({
                        type: 'GET',
                        url: '/Pedidos/AdicionarItemDesejo?codProduto=' + item.cod,
                        success: function (r) {
                            if (r.sucesso) {
                                ActiveIconDes(cod, true);
                                localStorage.setItem('aioDes', JSON.stringify({ offUser: false, des: [{ cod, nome, valor, qtd, urlImg, url }] }));
                                swal(nome, "Foi adicionado em sua lista de desejos.", "success");
                                LoadDes();
                            }
                            else
                                swal("Atenção", r.mensagem, "error");
                        },
                        error: function (e) {
                            swal("Atenção", "Erro ao adicionar em sua lista de desejos. Tente novamente.", "error");
                        }
                    });
                }
                else {
                    var done = false;
                    aioDes = JSON.parse(aioDes);
                    aioDes.des.forEach(function (item, i) {
                        if (item.cod == cod && !done) {
                            swal(nome, "Já está adicionado em sua lista de desejos.", "success");
                            done = true;
                        }
                    });
                    if (!done) {
                        $.ajax({
                            type: 'GET',
                            url: '/Pedidos/AdicionarItemDesejo?codProduto=' + cod,
                            success: function (r) {
                                if (r.sucesso) {
                                    aioDes.des.push({ cod, nome, valor, qtd, urlImg, url });
                                    localStorage.setItem('aioDes', JSON.stringify(aioDes));
                                    swal(nome, "Foi adicionado em sua lista de desejos.", "success");
                                    LoadDes();
                                }
                                else
                                    swal("Atenção", r.mensagem, "error");
                            },
                            error: function (e) {
                                swal("Atenção", "Erro ao adicionar em sua lista de desejos. Tente novamente.", "error");
                            }
                        });
                    }
                }
            }
        }
        else
            swal("Atenção", "Erro ao adicionar em sua lista de desejos. Tente novamente.", "error");
    }
}
function RemoverDes(cod) {
    if (getCookie('aiopcod') == null)
        RemoverDesLocal(cod);
    else
        RemoverDesDB(cod);

    function RemoverDesLocal(cod) {
        if (cod != undefined) {
            if (cod > 0) {
                var aioDes = JSON.parse(localStorage.getItem('aioDes'));
                aioDes.des.forEach(function (item, i) {
                    if (item.cod == cod) {
                        ActiveIconDes(cod, false);
                        aioDes.des.splice(i, 1);
                        localStorage.setItem('aioDes', JSON.stringify(aioDes));
                        OpenDes();
                        LoadDes();
                    }
                });
            }
        }
    }
    function RemoverDesDB(cod) {
        if (cod != undefined) {
            if (cod > 0) {
                var aioDes = JSON.parse(localStorage.getItem('aioDes'));
                aioDes.des.forEach(function (item, i) {
                    if (item.cod == cod) {
                        $.ajax({
                            type: 'GET',
                            url: '/Pedidos/RemoverItemDesejo?codProduto=' + cod,
                            success: function (r) {
                                if (r.sucesso) {
                                    ActiveIconDes(cod, false);
                                    aioDes.des.splice(i, 1);
                                    localStorage.setItem('aioDes', JSON.stringify(aioDes));
                                    OpenDes();
                                    LoadDes();
                                }
                                else
                                    swal("Atenção", r.mensagem, "error");
                            },
                            error: function (e) {
                                swal("Atenção", "Erro ao remover o item da lista. Tente novamente.", "error");
                            }
                        });
                    }
                });
            }
        }
    }
}
function ActiveIconDes(cod, on) {
    if (on) {
        $('.iconDes_' + cod).addClass('desOn');
        $('.iconDes_' + cod).find('.onIcon').css('opacity', '1');
    }
    else {
        $('.iconDes_' + cod).removeClass('desOn');
        $('.iconDes_' + cod).find('.onIcon').css('opacity', '0');
    }
}
function CarregarListaDesejoUsuario() {
    var aioDes = localStorage.getItem('aioDes');
    if (aioDes != null) {
        aioDes = JSON.parse(aioDes);
        if (aioDes.offUser) {
            $.ajax({
                type: 'POST',
                url: '/Pedidos/AtualizarItensDesejo',
                data: { itens: aioDes.des },
                success: function (r) {
                    if (r.sucesso) {
                        r.obj.forEach(function (item, i) {
                            item.valor = item.valor.toString().replace('.', ',');
                        });
                        localStorage.setItem('aioDes', JSON.stringify({ offUser: false, des: r.obj }));
                        removeCookie('aioploadingUser');
                        if (localStorage.getItem('aioCar') == null)
                            ObterCarrinho();
                    }
                    LoadDes();
                    if (localStorage.getItem('goToCart') != null)
                        window.location.href = '/Carrinho';
                },
                error: function (e) {
                    LoadDes();
                }
            });
        }
        else
            ObterListaDesejo();
    }
    else
        ObterListaDesejo();
}
function ObterListaDesejo() {
    $.ajax({
        type: 'GET',
        url: '/Pedidos/ObterItensDesejo',
        success: function (r) {
            if (r.sucesso) {
                r.obj.forEach(function (item, i) {
                    item.valor = item.valor.toString().replace('.', ',');
                });
                localStorage.setItem('aioDes', JSON.stringify({ offUser: false, des: r.obj }));
                removeCookie('aioploadingUser');
            }
            LoadDes();
            if (localStorage.getItem('goToCart') != null)
                window.location.href = '/Carrinho';
        },
        error: function (e) {
            LoadDes();
        }
    });
}