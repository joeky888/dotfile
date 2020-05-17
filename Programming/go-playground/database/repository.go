package database

func CreateNewUser(user *User) error {
	return DB.Create(&User{
		UserName: user.UserName,
		Password: bcryptHash(user.Password),
	}).Error
}

func SearchUser(u *User) bool {
	var user = User{UserName: u.UserName}
	if err := DB.First(&user).Error; err != nil {
		return false
	}

	if !bcryptCompare(user.Password, u.Password) {
		return false
	}
	*u = user
	return true
}

func SearchUserByID(uid uint32) (*User, error) {
	var user = User{}
	if err := DB.First(&user, "id = ?", uid).Error; err != nil {
		return nil, err
	}
	return &user, nil
}
