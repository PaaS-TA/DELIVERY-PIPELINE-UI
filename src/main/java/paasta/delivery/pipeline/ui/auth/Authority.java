package paasta.delivery.pipeline.ui.auth;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;

/**
 * Created by Mingu on 2017-05-31.
 */

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Authority {
    private String id;
    private String displayName;
    private String description;
    private String code;
    private String authType;

    private List<GrantedAuthority> grantedAuthorities;

    public Authority() {}

    public Authority(String id) {
        this.id = id;
    }

    public Authority(String id, String displayName) {
        this.id = id;
        this.displayName = displayName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<GrantedAuthority> getGrantedAuthorities() {
        return grantedAuthorities;
    }

    public void setGrantedAuthorities(List<GrantedAuthority> grantedAuthorities) {
        this.grantedAuthorities = grantedAuthorities;
    }

    public String getAuthType() {
        return authType;
    }

    public void setAuthType(String authType) {
        this.authType = authType;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "Authority{" +
                "id='" + id + '\'' +
                ", displayName='" + displayName + '\'' +
                ", description='" + description + '\'' +
                ", code='" + code + '\'' +
                ", authType='" + authType + '\'' +
                ", grantedAuthorities=" + grantedAuthorities +
                '}';
    }
}
