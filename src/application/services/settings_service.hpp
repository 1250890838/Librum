#pragma once
#include <QByteArray>
#include <QJsonObject>
#include <QSettings>
#include <memory>
#include "i_settings_service.hpp"
#include "i_settings_storage_gateway.hpp"

namespace application::services
{

class SettingsService : public ISettingsService
{
    Q_OBJECT

public:
    SettingsService(ISettingsStorageGateway* settingsStorageGateway);

    QString getSetting(const QString& settingName) override;
    void setSetting(const QString& settingName, const QString& value) override;
    void clearSettings() override;

public slots:
    void loadUserSettings(const QString& token, const QString& email) override;
    void clearUserData() override;

private slots:
    void mergeSettings(const QByteArray& data, bool success);

private:
    void createSettings();
    QString getUniqueUserHash() const;
    void generateDefaultSettings();
    QJsonObject getDefaultSettings();
    QByteArray getSettingsAsBytes();
    bool settingsAreValid();
    void writeDataToSettingsFile(const QByteArray& data);

    ISettingsStorageGateway* m_settingsStorageGateway;
    std::unique_ptr<QSettings> m_settings;
    QString m_defaultSettingsFile = ":/resources/data/default_settings.json";
    QString m_userEmail;
    QString m_authToken;
    bool m_settingsAreValid = false;
};

}  // namespace application::services