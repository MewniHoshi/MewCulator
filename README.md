# МяуКулятор (MeowCulator)

Калькулятор всего: один сборник повседневных расчётов вместо десятка отдельных
приложений. Разработчик — MewProg (ИП Гунько Александр Сергеевич),
контакт: Mewprog@gmail.com.

## Как устроено

* **Kotlin + Jetpack Compose + Material 3.** Нативного кода нет вообще.
* **Реестр калькуляторов.** Каждый расчёт — запись `CalcTool` в
  `core/registry/CalcRegistry.kt`: поля, ключевые слова для поиска и чистая
  функция `compute(Inputs): Results`. Универсальный экран
  (`feature/tool/ToolScreen.kt`) рисует форму по этому описанию, так что добавить
  расчёт — это запись в реестре, функция и unit-тест, а не новый экран.
* **Числа на `BigDecimal`.** Молча неверный результат в калькуляторе хуже падения,
  поэтому `double` в расчётах не используется.
* **Цвет только через токены.** `ui/theme/AppPalette.kt` — единственный источник
  цвета; `Color(0xFF...)` в экранах запрещён.
* **Room** — история и избранное, **DataStore** — настройки и введённые значения.

## Сеть и аналитика

Разрешения: только `INTERNET` и `ACCESS_NETWORK_STATE` (список проверяется при
каждой сборке, см. `allowedPermissions` в `app/build.gradle.kts`).

* **Яндекс AppMetrica** — анонимные сессии (DAU/MAU, удержание) и три события:
  `tool_open`, `calc_equals`, `converter_used` (см. `core/analytics/Analytics.kt`).
  В событиях только id расчёта, никаких введённых чисел. Геолокация и рекламный
  идентификатор выключены. В debug-сборке и при пустом ключе аналитика не включается.
  Ключ — `appmetricaApiKey` в `gradle.properties` (берётся в appmetrica.yandex.ru).
* На этапе «Валюты» добавятся курсы ЦБ РФ с `cbr.ru/scripts/XML_daily.asp`,
  с кешем в Room и офлайн-режимом.
* Рекламных SDK и загружаемых шрифтов нет.

## Сборка

* AGP 8.7.3, Kotlin 2.0.21, Gradle 8.9, JDK 17 (в Android Studio выбирайте JVM 21 —
  Gradle 8.9 не работает с JDK 25).
* compileSdk 35, minSdk 26, targetSdk 35.
* Путь проекта содержит кириллицу, поэтому в `gradle.properties` включён
  `android.overridePathCheck=true`.

```
./gradlew assembleDebug
./gradlew testDebugUnitTest
```
