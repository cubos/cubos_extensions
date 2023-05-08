# RubikUtils

The RubikUtils package aims to centralize all code that is common between Flutter projects at Cubos Tecnologia, avoiding code duplication and reducing development time in projects. The package contains the most used extension functions in projects and utilities, such as formatters, validators, etc.

## Features

### Validations

    RubikCPFValidator
    RubikCNPJValidator
    RubikValidatorType
    RubikStringValidations or RString

### Formatters

    RubikFormatterBase
    RubikCPFInputFormatter
    RubikCNPJInputFormatter
    RubikCPFCNPJInputFormatter
    RubikMoneyInputFormatter

### Object Extensions

    isNull
    isNotNull
    isInstanceOf
    castAs
    ifNotNull
    ifNotNullThen
    ifNullThen
    isNotNullOrEmpty
    className

### List Extensions

    removeDuplicates
    addWhere
    groupListBy
    isUnique
    isNotUnique
    toDuration
    toDateTime
    toIntegers
    toDoubles
    sum
    replace
    findMax
    findMin
    countOccurrences
    countOccurrences
    average
    rotate

### Durations Extensions

    dayStr
    hourStr
    minuteStr
    secondStr
    addHours
    addMinutes
    addSeconds
    add
    subtractHours
    subtractMinutes
    subtractSeconds
    subtract
    toNumberOfWeeks
    toNumberOfMonths
    toNumberOfYears
    daysWithSuffix
    hoursWithSuffix
    minutesWithSuffix
    secondsWithSuffix
    toTimeStr
    toDateTime
    microseconds - us
    milliseconds - ms
    seconds - s
    minutes - min
    hours - h
    days - d

### DateTime Extensions

    dayStr 
    monthStr 
    yearStr 
    hourStr 
    minuteStr 
    secondStr 
    toDateTimeStr 
    toIsoStr 
    subtractYears
    subtractDays
    subtractMonths
    subtractHours
    subtractDate
    toList
    toTimeStr
    toDateAndTimeStr
    toWeekdayStr
    toMonthNameStr
    toFullDateTimeStr
    isBetween

### Numbers Extensions

    isInteger
    isDouble
    toCents
    toReal
    toRealWithTwoDecimals
    hasDecimal
    formatToCurrency
    toRealWithFormatting
    toPercentage
    lessThan
    greaterThan
    isBetween
    pow
    toDegrees
    toRadians
    roundToNearest
    padLeft
    padRight

*OBS: O Método toPercentage(), não considera a conversação para porcentagem, apenas formata o número para o formato de porcentagem.*

### String Extensions

    withoutDigits
    digitsOnly
    cleanCpf
    cleanZipCode
    cleanPhone
    isNumeric
    capitalize
    capitalizeWords
    firstName
    lastChars
    socialName
    hasUppercase
    hasLowercase
    hasLetter
    hasDigits
    hasSpecialCharacters
    toDateTime
    toInt
    toDouble
    isCpf
    isCnpj
    isCpfOrCnpj
    noNBSP

## Let's grow together

You can support us making your own contributions! Report bugs or unexpected behaviors and suggest new features on the issues page from the [Gitlab repository](https://git.cubos.io/cubos/flutter-packages/rubik_utils). All the Pull Requests must have complete unit tests as requirement to be accepted.
