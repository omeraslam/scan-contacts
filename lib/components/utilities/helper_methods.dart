final nameRegex = RegExp(r'(?:\b[\w\d]+\s+)');
final phoneNumberRegex = RegExp(r'^\+?\d+(?:[\s-]\d+)*\b');
final internationalPhoneRegex = RegExp(r'^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$');
//^(?:[+0]9)?[0-9]{10}$
final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
final addressRegex = RegExp(
    r'\s*([0-9]*)\s((NW|SW|SE|NE|S|N|E|W))?(.*)((NW|SW|SE|NE|S|N|E|W))?((#|APT|BSMT|BLDG|DEPT|FL|FRNT|HNGR|KEY|LBBY|LOT|LOWR|OFC|PH|PIER|REAR|RM|SIDE|SLIP|SPC|STOP|STE|TRLR|UNIT|UPPR|\,)[^,]*)(\,)([\s\w]*)\n');
final urlsRegex =
    new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
final designationRegex = RegExp(r'(?:\b[\w\d]+\s+)');
