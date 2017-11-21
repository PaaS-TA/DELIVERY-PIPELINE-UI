package paasta.delivery.pipeline.ui.qualityProfile;

import java.util.List;


/**
 * The type Quality profile.
 */
public class QualityProfile {

    // --- Create :: s
    private String name;
    private String language;
    private String key;
    private String languageName;
    private String isDefault;
    private String isInherited;
    // --- Create ::e

    // --- Copy :: s
    private String fromKey;
    private String toName;
    // --- Copy :: e

    // --- Delete :: s
    private String profileKey;
    private String profileName;
    // --- Delete :: e

    // --- Rule :: s
    private String languages;
    // --- Rule :: e
    // --- Project :: s
    private String selected;
    private List results;
    // --- Project :: e
    // --- Etc
    private String serviceInstanceId;
    private String resultStatus;
    private String resultMessage;

    /**
     * Gets name.
     *
     * @return the name
     */
// --- getter/setter :: s
    public String getName() {
        return name;
    }

    /**
     * Sets name.
     *
     * @param name the name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets language.
     *
     * @return the language
     */
    public String getLanguage() {
        return language;
    }

    /**
     * Sets language.
     *
     * @param language the language
     */
    public void setLanguage(String language) {
        this.language = language;
    }

    /**
     * Gets key.
     *
     * @return the key
     */
    public String getKey() {
        return key;
    }

    /**
     * Sets key.
     *
     * @param key the key
     */
    public void setKey(String key) {
        this.key = key;
    }

    /**
     * Gets language name.
     *
     * @return the language name
     */
    public String getLanguageName() {
        return languageName;
    }

    /**
     * Sets language name.
     *
     * @param languageName the language name
     */
    public void setLanguageName(String languageName) {
        this.languageName = languageName;
    }

    /**
     * Gets is default.
     *
     * @return the is default
     */
    public String getIsDefault() {
        return isDefault;
    }

    /**
     * Sets is default.
     *
     * @param isDefault the is default
     */
    public void setIsDefault(String isDefault) {
        this.isDefault = isDefault;
    }

    /**
     * Gets is inherited.
     *
     * @return the is inherited
     */
    public String getIsInherited() {
        return isInherited;
    }

    /**
     * Sets is inherited.
     *
     * @param isInherited the is inherited
     */
    public void setIsInherited(String isInherited) {
        this.isInherited = isInherited;
    }

    /**
     * Gets service instance id.
     *
     * @return the service instance id
     */
    public String getServiceInstanceId() {
        return serviceInstanceId;
    }

    /**
     * Sets service instance id.
     *
     * @param serviceInstanceId the service instance id
     */
    public void setServiceInstanceId(String serviceInstanceId) {
        this.serviceInstanceId = serviceInstanceId;
    }

    /**
     * Gets languages.
     *
     * @return the languages
     */
    public String getLanguages() {
        return languages;
    }

    /**
     * Sets languages.
     *
     * @param languages the languages
     */
    public void setLanguages(String languages) {
        this.languages = languages;
    }

    /**
     * Gets selected.
     *
     * @return the selected
     */
    public String getSelected() {
        return selected;
    }

    /**
     * Sets selected.
     *
     * @param selected the selected
     */
    public void setSelected(String selected) {
        this.selected = selected;
    }


    /**
     * Gets results.
     *
     * @return the results
     */
    public List getResults() {
        return results;
    }

    /**
     * Sets results.
     *
     * @param results the results
     */
    public void setResults(List results) {
        this.results = results;
    }

    /**
     * Gets result status.
     *
     * @return the result status
     */
    public String getResultStatus() {
        return resultStatus;
    }

    /**
     * Sets result status.
     *
     * @param resultStatus the result status
     */
    public void setResultStatus(String resultStatus) {
        this.resultStatus = resultStatus;
    }

    /**
     * Gets result message.
     *
     * @return the result message
     */
    public String getResultMessage() {
        return resultMessage;
    }

    /**
     * Sets result message.
     *
     * @param resultMessage the result message
     */
    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    /**
     * Gets from key.
     *
     * @return the from key
     */
    public String getFromKey() {
        return fromKey;
    }

    /**
     * Sets from key.
     *
     * @param fromKey the from key
     */
    public void setFromKey(String fromKey) {
        this.fromKey = fromKey;
    }

    /**
     * Gets to name.
     *
     * @return the to name
     */
    public String getToName() {
        return toName;
    }

    /**
     * Sets to name.
     *
     * @param toName the to name
     */
    public void setToName(String toName) {
        this.toName = toName;
    }

    public String getProfileKey() {
        return profileKey;
    }

    public void setProfileKey(String profileKey) {
        this.profileKey = profileKey;
    }

    public String getProfileName() {
        return profileName;
    }

    public void setProfileName(String profileName) {
        this.profileName = profileName;
    }
// --- getter/setter :: e

    @Override
    public String toString() {
        return "QualityProfile{" +
                "name='" + name + '\'' +
                ", language='" + language + '\'' +
                ", key='" + key + '\'' +
                ", languageName='" + languageName + '\'' +
                ", isDefault='" + isDefault + '\'' +
                ", isInherited='" + isInherited + '\'' +
                ", fromKey='" + fromKey + '\'' +
                ", toName='" + toName + '\'' +
                ", profileKey='" + profileKey + '\'' +
                ", profileName='" + profileName + '\'' +
                ", languages='" + languages + '\'' +
                ", selected='" + selected + '\'' +
                ", results=" + results +
                ", serviceInstanceId='" + serviceInstanceId + '\'' +
                ", resultStatus='" + resultStatus + '\'' +
                ", resultMessage='" + resultMessage + '\'' +
                '}';
    }
}
