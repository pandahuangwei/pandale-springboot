package com.pandale.common.exception.user;

import com.pandale.common.exception.base.BaseException;

/**
 * 用户信息异常类
 * 
 * @author panda.
 */
public class UserException extends BaseException
{
    private static final long serialVersionUID = 1L;

    public UserException(String code, Object[] args)
    {
        super("user", code, args, null);
    }
}
