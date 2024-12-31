<%@ page import="org.myservlets.Area" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Text Quest</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <style>
            /* Общие стили */
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                color: white;
                background-color: #333;
                text-align: center;
            }

            h1 {
                font-size: 3em;
                text-shadow: 2px 2px 5px rgba(0,0,0,0.7);
                margin-top: 0;
            }

            hr {
                border: 1px solid #fff;
                width: 50%;
                margin: 20px auto;
            }

            .button {
                padding: 15px 30px;
                font-size: 1.2em;
                margin: 10px;
                background-color: rgba(0, 123, 255, 0.6);
                border: none;
                color: white;
                cursor: pointer;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .button:hover {
                background-color: rgba(0, 123, 255, 0.9);
            }

            .restart-button {
                background-color: #d9534f;
            }

            .restart-button:hover {
                background-color: #c9302c;
            }

            .hero-health.low-health {
                color: red;
                font-weight: bold;
            }

            #options-container {
                margin-top: 20px;
            }

            #story-container {
                margin-top: 20px;
                padding: 20px;
                background-color: rgba(0, 0, 0, 0.7);
                border-radius: 10px;
            }

            /* Анимация для текста */
            .fade-in {
                animation: fadeIn 2s ease-in-out;
            }

            @keyframes fadeIn {
                0% { opacity: 0; }
                100% { opacity: 1; }
            }

            /* Для кнопок */
            .button, .restart-button {
                font-size: 1.5em;
            }
        </style>
</head>
<body>
    <c:set var="START_LOCATION" value="<%= Area.START_LOCATION %>"/>
    <c:set var="SHEEP" value="<%= Area.SHEEP %>"/>
    <c:set var="CAPTAIN_BRIDGE" value="<%= Area.CAPTAIN_BRIDGE %>"/>
    <c:set var="SPACE" value="<%= Area.SPACE %>"/>
    <c:set var="HOME" value="<%= Area.HOME %>"/>

    <c:if test="${area == START_LOCATION}">
        <h1>Неизвестное место</h1>
        <hr>
        <p>НЛО предлагают тебе подняться на корабль. Принять предложение?</p>
    </c:if>

    <c:if test="${area == SHEEP}">
        <h1>Космический корабль</h1>
        <hr>
        <p>Ты поднялся на корабль. Капитан приглашает тебя на капитанский мостик. Принять предложение?</p>
    </c:if>

    <c:if test="${area == CAPTAIN_BRIDGE}">
        <h1>Капитанский мостик</h1>
        <hr>
        <p>Капитан спрашивает кто ты. Что ответишь?</p>
    </c:if>

    <c:if test="${area == HOME}">
        <h1>Дом, милый дом</h1>
        <hr>
        <p>Вас вернули домой</p>
    </c:if>

    <c:if test="${area == SPACE}">
        <h1>Открытый космос</h1>
        <hr>
        <p>Вас вышвырнули в пустое пространство</p>
    </c:if>

    <div id="options-container">
        <form id="options-form">
            <c:if test="${lose == true || win == true}">
                <button type="button" class="restart-button" onclick="restart()">Начать сначала</button>
            </c:if>

            <c:if test="${area == START_LOCATION}">
                <button type="button" class="button" onclick="selectOption('sheep')">Подняться на корабль</button>
                <button type="button" class="button" onclick="selectOption('loseSheep')">Отказаться</button>
            </c:if>

            <c:if test="${area == SHEEP}">
                <button type="button" class="button" onclick="selectOption('bridge')">Зайти на мостик</button>
                <button type="button" class="button" onclick="selectOption('loseBridge')">Отказаться</button>
            </c:if>

            <c:if test="${area == CAPTAIN_BRIDGE}">
                <button type="button" class="button" onclick="selectOption('sayTrueQ')">Сказать правду</button>
                <button type="button" class="button" onclick="selectOption('sayLieQ')">Соврать</button>
            </c:if>
        </form>
    </div>

    <div id="story-container">
        <c:if test="${win == true}">
            <p>Победа.</p>
        </c:if>

        <c:if test="${lose == true}">
            <p>Вы проиграли.</p>
       </c:if>
    </div>

    <script>
        // Функция для перезапуска игры
        function restart() {
            fetch('/restart', {
                method: 'POST'
            })
            .then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    console.error('Ошибка при перезапуске');
                }
            })
            .catch(error => console.error('Ошибка:', error));
        }

        // Функция для отправки действия пользователя
        function selectOption(action) {
            fetch('start', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'action=' + encodeURIComponent(action)
            })
            .then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    console.error('Ошибка при отправке действия');
                }
            })
            .catch(error => console.error('Ошибка:', error));
        }
    </script>
</body>
</html>
