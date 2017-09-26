package paasta.delivery.pipeline.ui.auth;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;


/**
 * Created by Mingu on 2017-05-31.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GrantedAuthority {
    private String id;

    @JsonProperty("instance_use_id")
    private Long instanceUseId;

    private Authority authority;

    @JsonProperty("authority_id")
    private String authorityId;

    private Long authCode;

    private String userId;

    private Long pipelineId;

    private String description;

    private Date created;

    public GrantedAuthority() {}

    public GrantedAuthority(String id, Long instanceUseId, String authorityId) {
        this.id = id;
        this.instanceUseId = instanceUseId;
        this.authority = new Authority(authorityId);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Long getInstanceUseId() {
        return instanceUseId;
    }

    public void setInstanceUseId(Long instanceUseId) {
        this.instanceUseId = instanceUseId;
    }

    public String getAuthorityId() {
        return authorityId;
    }

    public void setAuthorityId(String authorityId) {
        this.authorityId = authorityId;
    }

    public Authority getAuthority() {
        return authority;
    }

    public void setAuthority(Authority authority) {
        this.authority = authority;
    }

    public Long getAuthCode() {
        return authCode;
    }

    public void setAuthCode(Long authCode) {
        this.authCode = authCode;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Long getPipelineId() {
        return pipelineId;
    }

    public void setPipelineId(Long pipelineId) {
        this.pipelineId = pipelineId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }


}
