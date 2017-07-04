package main

type StoreObject struct {
	User   TelegramUser
	ChatId int
}

type InMessage struct {
	RecipientToken string `json:"recipient_token"`
	Text           string `json:"text"`
	IsMarkdown     bool   `json:"is_markdown"`
}

// Only required fields are implemented
type TelegramUser struct {
	Id        int    `json:"id`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	Username  string `json:"username"`
}

// Only required fields are implemented
type TelegramChat struct {
	Id   int    `json:"id`
	Type string `json:"type"`
}

// Only required fields are implemented
type TelegramOutMessage struct {
	ChatId    string `json:"chat_id"`
	Text      string `json:"text"`
	ParseMode string `json:"parse_mode"`
}

// Only required fields are implemented
type TelegramInMessage struct {
	MessageId string       `json:"message_id"`
	From      TelegramUser `json:"from"`
	Date      int          `json:"date"`
	Chat      TelegramChat `json:"chat"`
}

// Only required fields are implemented
type TelegramUpdate struct {
	UpdateId int               `json:"update_id"`
	Message  TelegramInMessage `json:"message"`
}
