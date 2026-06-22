*** Variables ***

${open_account_link}    xpath=//a[text()="Open New Account"]
${options}      xpath=//select[@id="fromAccountId"]/option
${checking}    xpath=//select[@id="type"]/option[text()="CHECKING"]
${savings}    xpath=//select[@id="type"]/option[text()="SAVINGS"]
${open_account_btn}    xpath=//input[@value="Open New Account"]