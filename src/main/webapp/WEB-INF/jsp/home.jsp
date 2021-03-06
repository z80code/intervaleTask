<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

<html lang="en" ng-app="myApp">
<head>
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container" ng-controller="MainCntl">
    <div style="text-align: center"><h2>Сервис приема денежных переводов</h2></div>
    <form class="form-horizontal {{input_form_visibility}}" role="form" id="sender">
        <fieldset>
            <legend>Введите данные вашей карты</legend>
            <div class="form-group">
                <label class="col-sm-3 control-label">Имя держателя</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="client_ownerName" placeholder="Имя держателя"
                           ng-model="moneyTransfer.clientCard.ownerName" id="con" ng-change="value_changed()">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Номер карты</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="client_cardNumber" ng-change="value_changed()"
                           placeholder="Номер карты" ng-model="moneyTransfer.clientCard.number" id="ccn">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label" for="ccb">Тип карты</label>
                <div class="col-sm-3">
                    <select class="form-control" name="client_cardBrand" id="ccb"
                            ng-model="moneyTransfer.clientCard.brand" ng-change="value_changed()">
                        <option>Тип карты</option>
                        <option ng-repeat="brand in brands" value="{{brand}}">
                            {{brand}}
                        </option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label" for="cey">Срок действия</label>
                <div class="col-sm-9">
                    <div class="row">
                        <div class="col-sm-3">
                            <select class="form-control col-sm-2" name="client_expiryMonth" id="cem"
                                    ng-model="client_expiry.month" ng-change="value_changed()">
                                <option>Месяц</option>
                                <option value="01">Январь (01)</option>
                                <option value="02">Февраль (02)</option>
                                <option value="03">Март (03)</option>
                                <option value="04">Апрель (04)</option>
                                <option value="05">Май (05)</option>
                                <option value="06">Июнь (06)</option>
                                <option value="07">Июль (07)</option>
                                <option value="08">Август (08)</option>
                                <option value="09">Сентябрь(09)</option>
                                <option value="10">Октябрь (10)</option>
                                <option value="11">Ноябрь (11)</option>
                                <option value="12">Декабрь (12)</option>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <select class="form-control" name="client_expiryYear" id="cey"
                                    ng-model="client_expiry.year" ng-change="value_changed()">
                                <option>Год</option>
                                <option ng-repeat="year in years" value="{{year}}">{{year}}</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <legend>Введите данные отправителя/получателя</legend>
            <div class="form-group">
                <label class="col-sm-3 control-label">Имя держателя</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="subclient_ownerName" ng-change="value_changed()"
                           placeholder="Имя держателя" ng-model="moneyTransfer.subClientCard.ownerName">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Номер карты</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="subclient_cardNumber" ng-change="value_changed()"
                           placeholder="Номер карты" ng-model="moneyTransfer.subClientCard.number">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label" for="subclient_expiryMonth">Срок действия</label>
                <div class="col-sm-9">
                    <div class="row">
                        <div class="col-sm-3">
                            <select class="form-control col-sm-2" id="subclient_expiryMonth"
                                    ng-model="subclient_expiry.month" ng-change="value_changed()">
                                <option>Месяц</option>
                                <option value="01">Январь (01)</option>
                                <option value="02">Февраль (02)</option>
                                <option value="03">Март (03)</option>
                                <option value="04">Апрель (04)</option>
                                <option value="05">Май (05)</option>
                                <option value="06">Июнь (06)</option>
                                <option value="07">Июль (07)</option>
                                <option value="08">Август (08)</option>
                                <option value="09">Сентябрь(09)</option>
                                <option value="10">Октябрь (10)</option>
                                <option value="11">Ноябрь (11)</option>
                                <option value="12">Декабрь (12)</option>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <select class="form-control" ng-model="subclient_expiry.year" ng-change="value_changed()">
                                <option>Год</option>
                                <option ng-repeat="year in years" value="{{year}}">{{year}}</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <legend>Введите валюту перевода</legend>
            <div class="form-group">
                <label class="col-sm-3 control-label" for="moneyTransfer.currency">Валюта</label>
                <div class="col-sm-3">
                    <select class="form-control" ng-model="moneyTransfer.currency" ng-change="value_changed()"
                            id="moneyTransfer.currency">
                        <option>Валюта перевода</option>
                        <option ng-repeat="currency in currencies" value="{{currency}}">{{currency}}</option>
                    </select>
                </div>
            </div>
            <legend>Введите сумму перевода</legend>
            <div class="form-group">
                <label class="col-sm-3 control-label">Сумма перевода</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="amount" ng-change="value_changed()"
                           placeholder="Сумма" ng-model="moneyTransfer.amount">
                </div>
            </div>
        </fieldset>
    </form>
    <div class="panel panel-default  {{check_visibility}}">
        <div class="panel-heading">Данные операции</div>
        <div class="panel-body">
            <h2>Ваши входные данные</h2>
            <p>Таблица содержит ваши входные данные для операции</p>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Поле</th>
                    <th>Значение</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Имя держателя</td>
                    <td>{{moneyTransfer.clientCard.ownerName}}</td>
                </tr>
                <tr>
                    <td>Номер карты</td>
                    <td>{{moneyTransfer.clientCard.number}}</td>
                </tr>
                <tr>
                    <td>Тип карты</td>
                    <td>{{moneyTransfer.clientCard.brand}}</td>
                </tr>
                <tr>
                    <td>Срок действия</td>
                    <td>{{client_expiry.month}}.{{client_expiry.year}}</td>
                </tr>
                </tbody>
            </table>
            <h2>Входные данные отправителя/получателя</h2>
            <p>Таблица содержит входные данные отправителя/получателя для операции</p>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Поле</th>
                    <th>Значение</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Имя держателя</td>
                    <td>{{moneyTransfer.subClientCard.ownerName}}</td>
                </tr>
                <tr>
                    <td>Номер карты</td>
                    <td>{{moneyTransfer.subClientCard.number}}</td>
                </tr>
                <tr>
                    <td>Срок действия</td>
                    <td>{{subclient_expiry.month}}.{{subclient_expiry.year}}</td>
                </tr>
                </tbody>
            </table>
            <h2>Данные перевода</h2>
            <p>Таблица содержит данные перевода</p>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Поле</th>
                    <th>Значение</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Валюта</td>
                    <td>{{moneyTransfer.currency}}</td>
                </tr>
                <tr>
                    <td>Сумма перевода</td>
                    <td>{{moneyTransfer.amount}}</td>
                </tr>
                </tbody>
            </table>
            <h2>Расчет</h2>
            <p>Для данной операции принята комиссия в размере: <strong>{{moneyTransfer.commission+"%"}}</strong>
            </p>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Описание</th>
                    <th>Значение</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>С учетом комиссии по данной операции равной:</td>
                    <td>{{moneyTransfer.commission+"%"}}</td>
                </tr>
                <tr>
                    <td>По сумме {{moneyTransfer.amount}} {{moneyTransfer.currency}} она составит:</td>
                    <td>{{moneyTransfer.commissionOfAmount}} {{moneyTransfer.currency}}</td>
                </tr>
                <tr>
                    <td>Общий платеж составит:</td>
                    <td>{{moneyTransfer.resultOperation}} {{moneyTransfer.currency}}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="alert alert-danger {{error_string_visibility}}">
        <strong>Внимание!</strong> {{error_string}}
    </div>
    <div class="alert alert-success {{success_string_visibility}}">
        <strong>Операция выполнена успешно!</strong>
    </div>
    <div class="form-group {{button_visibility}}" style="text-align: right">
        <div class="col-sm-offset-3 col-sm-9">
            <button type="reset" class="btn btn-warning" form="sender" ng-click="reset()">Сбросить
            </button>
            <button type="submit" class="btn btn-success" ng-click="onSend()">Выполнить</button>
        </div>
    </div>
    <div class="form-group {{restart_button_visibility}}" style="text-align: right">
        <div class="col-sm-offset-3 col-sm-9">
            <button type="submit" class="btn btn-success" ng-click="reset()">Провести еще одну операцию.
            </button>
        </div>
    </div>
</div>
<!-- Angular (necessary for Page plugins) -->
<script src="${pageContext.request.contextPath}/resources/angular/angular.min.js"></script>
<script>
    var myApp = angular.module('myApp', []);
    myApp.controller('MainCntl', ['$scope', '$http', function ($scope, $http) {
        var $hidden = "visibility: hidden";
        var $visibility = "visibility: visible";
        init();
        $scope.value_changed = function () {
            $scope.moneyTransfer.clientCard.validity = new Date($scope.client_expiry.year, $scope.client_expiry.month).getTime() / (1000);
            $scope.moneyTransfer.subClientCard.validity = new Date($scope.subclient_expiry.year, $scope.subclient_expiry.month).getTime() / (1000);
            if (fieldChecked()) {
                $http.post('/api/transfer/commission', $scope.moneyTransfer)
                        .success(function (moneyTransferBuff) {
                            $scope.moneyTransfer = moneyTransferBuff;

                            $scope.error_string_visibility =
                                    $scope.button_visibility =
                                            $scope.check_visibility = $hidden;
                            $scope.error_string = "";

                            console.log($scope.moneyTransfer.isError);

                            if ($scope.moneyTransfer.isError) {
                                $scope.error_string = $scope.moneyTransfer.status;
                                $scope.error_string_visibility = $visibility;
                            } else {
                                $scope.button_visibility =
                                        $scope.check_visibility = $visibility;
                            }
                        })
                        .error(function () {
                            $scope.error_string = "Ошибка соединения с сервисом или введены недопустимые значения.";
                            $scope.error_string_visibility = $visibility;
                            $scope.check_visibility =
                                    $scope.button_visibility = $hidden;
                        });
            } else {
                $scope.error_string = "Заполните все поля для операции.";
                $scope.button_visibility = $hidden;
                $scope.error_string_visibility = $visibility;
                $scope.check_visibility = $hidden;
            }
        };

        $scope.onSend = function () {
            $http.put('/api/transfer/put', $scope.moneyTransfer)
                    .success(function (result) {
                        if (result == "Success") {
                            $scope.button_visibility =
                                    $scope.input_form_visibility = $hidden;
                            $scope.success_string_visibility =
                                    $scope.restart_button_visibility = $visibility;
                        } else {
                            $scope.error_string = "Ошибка при выполнении операции.";
                            $scope.error_string_visibility = $visibility;
                        }
                    })
                    .error(function () {
                        $scope.error_string = "Ошибка соединения с сервисом.";
                        $scope.error_string_visibility = "visibility: visible";
                    });
        };

        function init() {
            $scope.moneyTransfer = ${mt};
            $scope.brands = ${brands};
            $scope.currencies = ${currencies};
            $scope.years = ${years};
            $scope.error_string = "Заполните все поля для операции.";
            $scope.error_string_visibility = $visibility;
            $scope.success_string_visibility =
                    $scope.button_visibility =
                            $scope.restart_button_visibility =
                                    $scope.check_visibility = $hidden;
            $scope.moneyTransfer.isError = true;
            $scope.moneyTransfer.clientCard.number = "";
            $scope.moneyTransfer.subClientCard.number = "";
            $scope.moneyTransfer.clientCard.brand = "Тип карты";
            $scope.moneyTransfer.currency = "Валюта перевода";
            $scope.client_expiry = {};
            $scope.subclient_expiry = {};
            $scope.client_expiry.month = $scope.subclient_expiry.month = "Месяц";
            $scope.client_expiry.year = $scope.subclient_expiry.year = "Год";
        }

        function fieldChecked() {
            return /(\d+)/.test($scope.client_expiry.month) && /\d+/.test($scope.client_expiry.year) &&
                    $scope.moneyTransfer.clientCard.ownerName && /\d+/.test($scope.moneyTransfer.clientCard.number) &&
                    in_array($scope.moneyTransfer.clientCard.brand, $scope.brands) &&
                    $scope.moneyTransfer.subClientCard.ownerName && /\d+/.test($scope.moneyTransfer.subClientCard.number) &&
                    /(\d+)/.test($scope.subclient_expiry.month) && /\d+/.test($scope.subclient_expiry.year) &&
                    in_array($scope.moneyTransfer.currency, $scope.currencies) &&
                    /\d+/.test($scope.moneyTransfer.amount) && $scope.moneyTransfer.amount > 0;
        }

        $scope.reset = function () {
            $scope.input_form_visibility = $visibility;
            $scope.check_visibility =
                    $scope.button_visibility =
                            $scope.success_string_visibility = $hidden;
            $scope.error_string_visibility = $visibility;
            $scope.restart_button_visibility = $hidden;
            $scope.error_string = "Заполните все поля для операции.";
        };

        function in_array(value, array) {
            for (var i = 0; i < array.length; i++) {
                if (array[i] == value) return true;
            }
            return false;
        }
    }]);

</script>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.1.1.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
