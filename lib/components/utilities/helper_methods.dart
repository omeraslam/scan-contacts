final nameRegex = RegExp(r"/^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/g");
final phoneNumberRegex = RegExp(r'^\+?\d+(?:[\s-]\d+)*\b');
final internationalPhoneRegex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
final addressRegex = RegExp(
    r'\s*([0-9]*)\s((NW|SW|SE|NE|S|N|E|W))?(.*)((NW|SW|SE|NE|S|N|E|W))?((#|APT|BSMT|BLDG|DEPT|FL|FRNT|HNGR|KEY|LBBY|LOT|LOWR|OFC|PH|PIER|REAR|RM|SIDE|SLIP|SPC|STOP|STE|TRLR|UNIT|UPPR|\,)[^,]*)(\,)([\s\w]*)\n');
final urlsRegex =
    new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
