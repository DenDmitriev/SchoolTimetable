//
//  Lorem.swift
//  Calendar
//
//  Created by Denis Dmitriev on 29.10.2023.
//

import Foundation

/// A lightweight lorem ipsum generator.
public final class Lorem {
    
    // ======================================================= //
    // MARK: - Text
    // ======================================================= //
    
    /// Generates a single word.
    public static var word: String {
        return allWords.randomElement()!
    }
    
    /// Generates multiple words whose count is defined by the given value.
    ///
    /// - Parameter count: The number of words to generate.
    /// - Returns: The generated words joined by a space character.
    public static func words(_ count: Int) -> String {
        return _compose(
            word,
            count: count,
            joinBy: .space
        )
    }
    
    /// Generates multiple words whose count is randomly selected from within the given range.
    ///
    /// - Parameter range: The range of number of words to generate.
    /// - Returns: The generated words joined by a space character.
    public static func words(_ range: Range<Int>) -> String {
        return _compose(word, count: Int.random(in: range), joinBy: .space)
    }
    
    /// Generates multiple words whose count is randomly selected from within the given closed range.
    ///
    /// - Parameter range: The range of number of words to generate.
    /// - Returns: The generated words joined by a space character.
    public static func words(_ range: ClosedRange<Int>) -> String {
        return _compose(word, count: Int.random(in: range), joinBy: .space)
    }
    
    /// Generates a single sentence.
    public static var sentence: String {
        let numberOfWords = Int.random(
            in: minWordsCountInSentence...maxWordsCountInSentence
        )
        
        return _compose(
            word,
            count: numberOfWords,
            joinBy: .space,
            endWith: .dot,
            decorate: { $0.firstLetterCapitalized }
        )
    }
    
    /// Generates multiple sentences whose count is defined by the given value.
    ///
    /// - Parameter count: The number of sentences to generate.
    /// - Returns: The generated sentences joined by a space character.
    public static func sentences(_ count: Int) -> String {
        return _compose(
            sentence,
            count: count,
            joinBy: .space
        )
    }
    
    /// Generates multiple sentences whose count is selected from within the given range.
    ///
    /// - Parameter count: The number of sentences to generate.
    /// - Returns: The generated sentences joined by a space character.
    public static func sentences(_ range: Range<Int>) -> String {
        return _compose(sentence, count: Int.random(in: range), joinBy: .space)
    }
    
    /// Generates multiple sentences whose count is selected from within the given closed range.
    ///
    /// - Parameter count: The number of sentences to generate.
    /// - Returns: The generated sentences joined by a space character.
    public static func sentences(_ range: ClosedRange<Int>) -> String {
        return _compose(sentence, count: Int.random(in: range), joinBy: .space)
    }
    
    /// Generates a single paragraph.
    public static var paragraph: String {
        let numberOfSentences = Int.random(
            in: minSentencesCountInParagraph...maxSentencesCountInParagraph
        )
        
        return _compose(
            sentence,
            count: numberOfSentences,
            joinBy: .space
        )
    }
    
    /// Generates multiple paragraphs whose count is defined by the given value.
    ///
    /// - Parameter count: The number of paragraphs to generate.
    /// - Returns: The generated paragraphs joined by a new line character.
    public static func paragraphs(_ count: Int) -> String {
        return _compose(
            paragraph,
            count: count,
            joinBy: .newLine
        )
    }
    
    /// Generates multiple paragraphs whose count is selected from within the given range.
    ///
    /// - Parameter count: The number of paragraphs to generate.
    /// - Returns: The generated paragraphs joined by a new line character.
    public static func paragraphs(_ range: Range<Int>) -> String {
        return _compose(
            paragraph,
            count: Int.random(in: range),
            joinBy: .newLine
        )
    }
    
    /// Generates multiple paragraphs whose count is selected from within the given closed range.
    ///
    /// - Parameter count: The number of paragraphs to generate.
    /// - Returns: The generated paragraphs joined by a new line character.
    public static func paragraphs(_ range: ClosedRange<Int>) -> String {
        return _compose(
            paragraph,
            count: Int.random(in: range),
            joinBy: .newLine
        )
    }
    
    /// Generates a capitalized title.
    public static var title: String {
        let numberOfWords = Int.random(
            in: minWordsCountInTitle...maxWordsCountInTitle
        )
        
        return _compose(
            word,
            count: numberOfWords,
            joinBy: .space,
            decorate: { $0.capitalized }
        )
    }
    
    // ======================================================= //
    // MARK: - Names
    // ======================================================= //
    
    /// Generates a first name.
    public static var firstName: String {
        return firstNames.randomElement()!
    }
    
    /// Generates a last name.
    public static var lastName: String {
        return lastNames.randomElement()!
    }
    
    /// Generates a full name.
    public static var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    // ======================================================= //
    // MARK: - Email Addresses & URLs
    // ======================================================= //
    
    /// Generates an email address.
    public static var emailAddress: String {
        let emailDelimiter = emailDelimiters.randomElement()!
        let emailDomain = emailDomains.randomElement()!
        
        return "\(firstName)\(emailDelimiter)\(lastName)@\(emailDomain)".lowercased()
    }
    
    /// Generates a URL.
    public static var url: String {
        let urlScheme = urlSchemes.randomElement()!
        let urlDomain = urlDomains.randomElement()!
        return "\(urlScheme)://\(urlDomain)"
    }
    
    // ======================================================= //
    // MARK: - Tweets
    // ======================================================= //
    
    /// Generates a random tweet which is shorter than 140 characters.
    public static var shortTweet: String {
        return _composeTweet(shortTweetMaxLength)
    }
    
    /// Generates a random tweet which is shorter than 280 characters.
    public static var tweet: String {
        return _composeTweet(tweetMaxLength)
    }
    
}

extension Lorem {
    
    fileprivate enum Separator: String {
        case none = ""
        case space = " "
        case dot = "."
        case newLine = "\n"
    }
    
    fileprivate static func _compose(
        _ provider: @autoclosure () -> String,
        count: Int,
        joinBy middleSeparator: Separator,
        endWith endSeparator: Separator = .none,
        decorate decorator: ((String) -> String)? = nil
    ) -> String {
        var string = ""
        
        for index in 0..<count {
            string += provider()
            
            if (index < count - 1) {
                string += middleSeparator.rawValue
            } else {
                string += endSeparator.rawValue
            }
        }
        
        if let decorator = decorator {
            string = decorator(string)
        }
        
        return string
    }
    
    fileprivate static func _composeTweet(_ maxLength: Int) -> String {
        for numberOfSentences in [4, 3, 2, 1] {
            let tweet = sentences(numberOfSentences)
            if tweet.count < maxLength {
                return tweet
            }
        }
        
        return ""
    }
    
    fileprivate static let minWordsCountInSentence = 4
    fileprivate static let maxWordsCountInSentence = 16
    fileprivate static let minSentencesCountInParagraph = 3
    fileprivate static let maxSentencesCountInParagraph = 9
    fileprivate static let minWordsCountInTitle = 2
    fileprivate static let maxWordsCountInTitle = 7
    fileprivate static let shortTweetMaxLength = 140
    fileprivate static let tweetMaxLength = 280
    
    fileprivate static let allWords = ["другие", "последствия", "или", "продолжительность", "быть", "удовольствие", "обвинители", "боль", "открыть", "она", "сама", "которая", "от ", "тот", "изобретатель", "истина", "и", "как будто", "архитектор", "блаженный", "жизнь", "сказал", "есть", "объясни", "аспернатур" , "или", "следовать", "не знаю", "ни", "боль", "сама", "потому что", "боль", "быть", "любовь", "получится", "получить", "будет", "но", "некоторые", "хочу", "удовольствие", "так", "для", "чтобы", "минимум", "прийти", "кто", " наше", "упражнение", "любое", "тело", "никто", "для", "себя", "удовольствие", "потому что", "удовольствие", "быть", "предпринимать", "трудоёмкий", "если", "так", "что-то", "от", "то", "преимущества", "последствия", "кто", "однако", "или", "его", "право", "критиковать", "кто", "в", "она", "с удовольствием", "будет", "быть", "что", "ничего", "заморачиваться", "и", "просто", " ненавидеть", "самого достойного", "мы ведем", "кто", "льстить", "представлять", "хвалить", "все", "вещь", "обрадовать", "уничтожать", "и", "испорчен", "который", "печали", "который", "беда", "кроме", "будет", "ослеплен", "похотью", "не", "обеспечивает", "но", "что", "воспринимают", "откуда", "все", "это", "рождено", "ошибка", "подобно", "находятся", "в", "вина"," кто", "обязанности", "отпуск", "мягкость", "ум", "оно", "есть", "труды", "и", "хитрости", "бегство", "и", "эти" , "действительно", "вещи", "легко", "есть", "и", "ускоренный", "отличие", "за", "свободно", "время", "с", "решено", " нас", "есть", "выбрать", "вариант", "ничего", "не мешает", "где", "дальше", "кто-либо", "есть", "кто", "меньше", " что", "что", "в основном", "пожалуйста", "сделать", "мы можем", "все", "удовольствие", "предполагается", "есть", "все", "боль", " отталкивались", "временами", "однако", "некоторые", "и", "или", "действительно", "их", "и", "обвиняем", "обязательства", "долги", "или", "вещи", "необходимость", "часто", "так произойдет", "чтобы", "и", "а", "мудрый", "избранный", "как", "или ", "отвергая", "наслаждает", "больше", "болезненнее", "грубее", "отталкивает"]

    fileprivate static let firstNames = ["Ярослав", "Александр", "Анна", "Ульяна", "Мирон", "Екатерина", "Анна", "Василиса", "Василий", "Дарья", "Василиса", "Михаил", "Мирон", "Савелий", "София", "Татьяна", "Мария", "Юлия", "Валерия", "Ярослав", "Кирилл", "Ярослав", "Егор", "Лев", "Кирилл", "Максим", "Платон", "Вероника", "Степан", "Таисия", "Мария", "Даниил", "Фёдор", "София", "Екатерина", "София", "Кира", "Артём", "Арина", "Евгений", "Даниил", "Полина", "Адам", "Михаил", "Никита", "Дмитрий", "Даниил", "Фёдор", "Елизавета", "Варвара", "Артемий", "Иван", "Мирон", "Арсений", "Василий", "Ирина", "Кирилл", "София", "Ксения", "Дарья", "Артём", "Александр", "Савелий", "Анна", "София", "Сергей", "Мария", "Артур", "Роман", "Юлия", "Артём", "Пётр", "Артём", "Мария", "Даниил", "Александра", "Максим", "Арина", "Анастасия", "Полина", "Константин", "Василиса", "Виктория", "Артемий", "Вера", "Арина", "Анна", "Матвей", "Пётр", "Илья", "Екатерина", "Дарья", "Владислав", "Матвей", "Платон", "Александра", "Александра", "Алиса", "Александр", "Кирилл", "Денис", "Анна", "Алина", "Полина", "Диана", "Дарья", "Юрий", "Дарья", "Полина", "Злата", "Ксения", "Яна", "Иван", "Василий", "София", "Василиса", "Василиса", "Руслан", "Полина", "Елизавета", "Варвара", "Мария", "Игорь", "Дмитрий", "Артём", "Филипп", "Ева", "Владислав", "Анна", "Юлия", "Семён", "Мирон", "Илья", "Алиса", "Арина", "Степан", "Варвара", "Михаил", "Даниил", "Дмитрий", "Никита", "Богдан", "Максим", "Мирослава", "Илья", "Константин", "Матвей", "Марк", "Дарья", "Тимур", "Дарья", "Ульяна", "Мария", "Платон", "София", "София", "Константин", "Яков", "Илья", "Милана", "Алиса", "Никита", "Анна", "Вероника", "Алина", "Василиса", "Даниил", "Александр", "Алиса", "Николай", "Тимур", "Мария", "Анастасия", "Владимир", "Мария", "Руслан", "Алёна", "Роман", "Александр", "Вероника", "Виктория", "Матвей", "Алина", "Полина", "Герман", "Дмитрий", "Варвара", "Валерия", "Никита", "Кира", "Марк", "Милана", "Кирилл", "Александра", "Маргарита", "Алиса", "Дарья", "Ярослав", "Александр", "Вероника"]
    
    fileprivate static let lastNames = ["Агафонов", "Акимов", "Александрова", "Александрова", "Алешин", "Андрианова", "Анохина", "Антонова", "Архипов", "Афанасьева", "Белякова", "Бирюков", "Бобров", "Большаков", "Борисова", "Борисова", "Бородина", "Булгакова", "Верещагина", "Власов", "Волков", "Волков", "Воробьев", "Гладков", "Головин", "Горлов", "Горшков", "Грачева", "Григорьев", "Григорьева", "Григорьева", "Громов", "Громов", "Громова", "Громова", "Гуляева", "Гусева", "Дементьев", "Демина", "Денисов", "Денисов", "Денисова", "Дмитриев", "Дмитриев", "Дубов", "Евсеев", "Елисеев", "Ермаков", "Ермакова", "Ефимова", "Ефремов", "Зайцев", "Зайцев", "Захаров", "Захаров", "Золотова", "Иванов", "Иванова", "Иванова", "Ильинская", "Казаков", "Калинин", "Калинин", "Карпова", "Касьянова", "Климов", "Климова", "Ковалев", "Ковалев", "Ковалева", "Козлов", "Козлов", "Козлов", "Козлова", "Колесников", "Комарова", "Кондратьев", "Кондратьева", "Коновалова", "Константинова", "Королев", "Королева", "Короткова", "Котов", "Кудряшова", "Кузина", "Кузнецова", "Кузьмин", "Кузьмин", "Кузьмин", "Кузьмина", "Кузьмина", "Лавров", "Ларин", "Лебедев", "Левина", "Литвинова", "Литвинова", "Лобанов", "Лосев", "Любимов", "Макарова", "Макарова", "Макарова", "Максимова", "Максимова", "Мальцев", "Мартынова", "Масленникова", "Масленникова", "Мельникова", "Миронова", "Молчанов", "Молчанов", "Молчанова", "Морозова", "Назарова", "Некрасов", "Николаева", "Николаева", "Николаева", "Никулина", "Новиков", "Озеров", "Орлов", "Орлов", "Орлова", "Павлов", "Панкратова", "Пахомова", "Петров", "Петров", "Петров", "Петрова", "Петухова", "Поляков", "Пономарева", "Попов", "Прокофьев", "Прохоров", "Прохоров", "Родионов", "Романов", "Румянцева", "Рыбаков", "Савицкий", "Сальников", "Сафонов", "Семенова", "Сергеев", "Сергеева", "Сергеева", "Сизова", "Синицын", "Синицына", "Скворцова", "Смирнов", "Смирнов", "Смирнов", "Смирнова", "Соболева", "Соколов", "Соловьева", "Старостина", "Степанова", "Степанова", "Судаков", "Суслов", "Сычева", "Тарасов", "Тарасов", "Тимофеева", "Тихонова", "Трофимов", "Туманова", "Устинов", "Устинова", "Ушаков", "Федоров", "Федорова", "Федорова", "Федотов", "Федотова", "Филатова", "Филимонов", "Филиппов", "Фомина", "Фролова", "Хромов", "Цветкова", "Чернышев", "Чижова", "Шапошников", "Широкова", "Шубина", "Щербакова", "Юдина", "Яковлев", "Яковлев", "Яшина"]
    
    fileprivate static let emailDomains = ["gmail.com", "yahoo.com", "hotmail.com", "email.com", "live.com", "me.com", "yandex.ru", "ya.ru", "fastmail.com", "mail.ru"]
    
    fileprivate static let emailDelimiters = ["", ".", "-", "_"]
    
    fileprivate static let urlSchemes = ["http", "https"]
    
    fileprivate static let urlDomains = ["twitter.com", "google.com", "youtube.com", "wordpress.org", "adobe.com", "blogspot.com", "godaddy.com", "wikipedia.org", "wordpress.com", "yahoo.com", "linkedin.com", "amazon.com", "flickr.com", "w3.org", "apple.com", "myspace.com", "tumblr.com", "digg.com", "microsoft.com", "vimeo.com", "pinterest.com", "stumbleupon.com", "youtu.be", "miibeian.gov.cn", "baidu.com", "feedburner.com", "bit.ly"]
    
}

extension String {
    
    fileprivate var firstLetterCapitalized: String {
        guard !isEmpty else { return self }
        return prefix(1).capitalized + dropFirst()
    }
    
}
