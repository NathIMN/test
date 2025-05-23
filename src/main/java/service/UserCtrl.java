package service;

import model.User;

public abstract class UserCtrl {
	public abstract User loginValidate(String un, String pw);
}
