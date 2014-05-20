package com.ecp.controller;

import javax.servlet.http.HttpServletRequest;

import org.brickred.socialauth.AuthProvider;
import org.brickred.socialauth.SocialAuthManager;
import org.brickred.socialauth.exception.SocialAuthException;
import org.brickred.socialauth.spring.bean.SocialAuthTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UpdateStatusController {
        @Autowired
        private SocialAuthTemplate socialAuthTemplate;

        @RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
        public ModelAndView getRedirectURL(final HttpServletRequest request)
                        throws Exception {
                ModelAndView mv = new ModelAndView();
                SocialAuthManager manager = socialAuthTemplate.getSocialAuthManager();
                AuthProvider provider = manager.getCurrentAuthProvider();
                String statusMsg = request.getParameter("statusMessage");
                try {
                        provider.updateStatus(statusMsg);
                        mv.addObject("Message", "Status Updated successfully");
                } catch (SocialAuthException e) {
                        mv.addObject("Message", e.getMessage());
                        e.printStackTrace();
                }
                mv.setViewName("/jsp/statusSuccess.jsp");

                return mv;
        }
}
