package com.pandale.admin.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.pandale.common.config.Global;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Swagger2的接口配置
 * 
 * @author panda.
 */
@Configuration
@EnableSwagger2
public class SwaggerConfig
{
    @Bean
    public Docket createCommonApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .groupName("通用")
                .apiInfo(apiCommonInfo())
                .select()
                // 指定当前包路径
                .apis(RequestHandlerSelectors.basePackage("com.pandale.admin.web.common"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiCommonInfo() {
        return new ApiInfoBuilder()
                .title("通用")
                .description("描述：通用模块，包含上传、下载")
                .contact(new Contact(Global.getName(), null, null))
                .version("版本号:" + Global.getVersion())
                .build();
    }

    @Bean
    public Docket createMonitorApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .groupName("系统监控模块")
                .apiInfo(apiMonitorInfo())
                .select()
                // 指定当前包路径
                .apis(RequestHandlerSelectors.basePackage("com.pandale.admin.web.monitor"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiMonitorInfo() {
        return new ApiInfoBuilder()
                .title("系统监控模块")
                .description("描述：系统监控模块，包含连接池，定时任务，在线...")
                .contact(new Contact(Global.getName(), null, null))
                .version("版本号:" + Global.getVersion())
                .build();
    }

    @Bean
    public Docket createSystemApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .groupName("后端管理模块")
                .apiInfo(apiSystemInfo())
                .select()
                // 指定当前包路径
                .apis(RequestHandlerSelectors.basePackage("com.pandale.admin.web.system"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiSystemInfo() {
        return new ApiInfoBuilder()
                .title("后端管理模块")
                .description("描述：系统后端管理模块...")
                .contact(new Contact(Global.getName(), null, null))
                .version("版本号:" + Global.getVersion())
                .build();
    }

    @Bean
    public Docket createToolApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .groupName("工具模块")
                .apiInfo(apiToolInfo())
                .select()
                // 指定当前包路径
                .apis(RequestHandlerSelectors.basePackage("com.pandale.admin.web.system"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiToolInfo() {
        return new ApiInfoBuilder()
                .title("工具模块")
                .description("描述：工具类...")
                .contact(new Contact(Global.getName(), null, null))
                .version("版本号:" + Global.getVersion())
                .build();
    }
}
