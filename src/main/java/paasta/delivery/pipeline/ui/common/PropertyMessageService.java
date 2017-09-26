package paasta.delivery.pipeline.ui.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.common
 *
 * @author REX
 * @version 1.0
 * @since 5 /12/2017
 */
@Service
public class PropertyMessageService {

    private MessageSourceAccessor messageSourceAccessor;


    /**
     * Instantiates a new Property message service.
     *
     * @param messageSourceAccessor the message source accessor
     */
    @Autowired
    public PropertyMessageService(MessageSourceAccessor messageSourceAccessor) {
        setMessageSourceAccessor(messageSourceAccessor);
    }


    /**
     * Gets message source accessor.
     *
     * @return the message source accessor
     */
    public MessageSourceAccessor getMessageSourceAccessor() {
        return messageSourceAccessor;
    }


    private void setMessageSourceAccessor(MessageSourceAccessor messageSourceAccessor) {
        this.messageSourceAccessor = messageSourceAccessor;
    }


    /**
     * Gets message.
     *
     * @param key the key
     * @return the message
     */
    public String getMessage(String key) {
        return messageSourceAccessor.getMessage(key);
    }


    /**
     * Gets message.
     *
     * @param key     the key
     * @param strings the strings
     * @return the message
     */
    public String getMessage(String key, String[] strings) {
        return messageSourceAccessor.getMessage(key, strings);
    }

}
