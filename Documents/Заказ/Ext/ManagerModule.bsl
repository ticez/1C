﻿
Процедура Печать(ТабДок, Ссылка) Экспорт
	//{{_КОНСТРУКТОР_ПЕЧАТИ(Печать)
	Макет = Документы.Заказ.ПолучитьМакет("Печать");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Заказ.Выполнен,
	|	Заказ.Дата,
	|	Заказ.Номер,
	|	Заказ.Сотрудник,
	|	Заказ.ТЧ1.(
	|		НомерСтроки,
	|		Номенклатура,
	|		Количество
	|	)
	|ИЗ
	|	Документ.Заказ КАК Заказ
	|ГДЕ
	|	Заказ.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьТЧ1Шапка = Макет.ПолучитьОбласть("ТЧ1Шапка");
	ОбластьТЧ1 = Макет.ПолучитьОбласть("ТЧ1");
	Подвал = Макет.ПолучитьОбласть("Подвал");

	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ТабДок.Вывести(ОбластьТЧ1Шапка);
		ВыборкаТЧ1 = Выборка.ТЧ1.Выбрать();
		Пока ВыборкаТЧ1.Следующий() Цикл
			ОбластьТЧ1.Параметры.Заполнить(ВыборкаТЧ1);
			ТабДок.Вывести(ОбластьТЧ1, ВыборкаТЧ1.Уровень());
		КонецЦикла;

		Подвал.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Подвал);

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	//}}
КонецПроцедуры
