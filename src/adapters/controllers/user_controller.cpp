#include "user_controller.hpp"


namespace adapters::controllers
{

UserController::UserController(application::IUserService* userService)
    : m_userService(userService)
{
    connect(m_userService, &application::IUserService::finishedLoadingUser,
            this, &UserController::proccessUserLoadingResult);
}


void UserController::loadUser()
{
    m_userService->loadUser();
}

QString UserController::getFirstName()
{
    return m_userService->getFirstName();
}

void UserController::setFirstName(const QString& newFirstName)
{
    if(newFirstName == m_userService->getFirstName())
        return;
    
    m_userService->setFirstName(newFirstName);
    emit firstNameChanged();
}


QString UserController::getLastName()
{
    return m_userService->getLastName();
}

void UserController::setLastName(const QString& newLastName)
{
    if(newLastName == m_userService->getLastName())
        return;
    
    m_userService->setLastName(newLastName);
    emit lastNameChanged();
}


QString UserController::getEmail()
{
    return m_userService->getEmail();
}

void UserController::setEmail(const QString& newEmail)
{
    if(newEmail == m_userService->getEmail())
        return;
    
    m_userService->setEmail(newEmail);
    emit emailChanged();
}

void UserController::proccessUserLoadingResult(bool success)
{
    emit firstNameChanged();
    emit lastNameChanged();
    emit emailChanged();
    
    emit finishedLoadingUser(success);
}

} // namespace adapters::controllers