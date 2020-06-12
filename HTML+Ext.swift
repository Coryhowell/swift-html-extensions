// Example html String 
        
        let html = """
                <p><span style=\"font-family: helvetica, arial, sans-serif; font-size: 12pt;\">We have many platforms available for you to connect with us through Social Media- </span></p>\n<p><span style=\"font-family: helvetica, arial, sans-serif; font-size: 12pt;\"><a href=\"https://www.facebook.com/newcovenantmb\">Facebook</a>&#8211; from the latest news to encouraging devotions to inspiring posts.</span></p>\n<p><span style=\"font-family: helvetica, arial, sans-serif; font-size: 12pt;\"><a href=\"https://www.facebook.com/newcovenantmb\">Facebook Live</a>&#8211; join us Sunday mornings @ 10:30 for Worship service.</span></p>\n<p><span style=\"font-family: helvetica, arial, sans-serif; font-size: 12pt;\"><a href=\"https://www.youtube.com/channel/UCdnAfVhy8Nkoy4N2Y7CZS3g?view_as=subscriber\">YouTube</a>&#8211; catch recent worship services on the <a href=\"https://www.youtube.com/playlist?list=PL9qodX6swokjbWul3GxkbdToPvvl0pHgx\">Sunday Worship playlist</a>.</span></p>\n<p><span style=\"font-family: helvetica, arial, sans-serif; font-size: 12pt;\"><a href=\"https://www.instagram.com/newcovenantmb/\">Instagram</a></span></p>\n<p><span style=\"font-family: helvetica, arial, sans-serif; font-size: 12pt;\"><a href=\"https://twitter.com/newcovenantmb\">Twitter</a></span></p>\n
        """


// html url link detector -> Extracts links from html code 
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: html, options: [], range: NSRange(location: 0, length: html.utf16.count))

        for match in matches {
            guard let range = Range(match.range, in: html) else { continue }
            let url = html[range]
            print(url)
            /*
            https://www.facebook.com/newcovenantmb
            https://www.facebook.com/newcovenantmb
            https://www.youtube.com/channel/UCdnAfVhy8Nkoy4N2Y7CZS3g?view_as=subscriber
            https://www.youtube.com/playlist?list=PL9qodX6swokjbWul3GxkbdToPvvl0pHgx
            https://www.instagram.com/newcovenantmb
            https://twitter.com/newcovenantmb
            */ 
            }
        
// Example UITextView -> w/ HTML as attributed string 
        {...}

        let attributedString = html.html2Attributed
        
        let text = UITextView()
        text.isEditable = false
        text.frame = CGRect(x: 10, y: 50, width: 350, height: 800)
        text.linkTextAttributes = [
            .foregroundColor: UIColor.secondaryLabel,
            .underlineColor: UIColor.clear
        ]
        text.attributedText = attributedString
        
        {...}

    }
}

// HTML Color & String Extensions 

extension UIColor {
    var hexString:String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}

extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var htmlAttributed: (NSAttributedString?, NSDictionary?) {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return (nil, nil)
            }

            var dict:NSDictionary?
            dict = NSMutableDictionary()

            return try (NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: &dict), dict)
        } catch {
            print("error: ", error)
            return (nil, nil)
        }
    }
    
    func htmlAttributed(using font: UIFont, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(font.pointSize)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(font.familyName), Helvetica !important;" +
                "}</style> \(self)"

            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }

            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }

    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
            "}</style> \(self)"

            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }

            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}