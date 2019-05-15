# The baseline for module testing used by Puppet Inc. is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# https://docs.puppet.com/guides/tests_smoke.html


# include ::helm

# helm related
class { 'helm':
    version         => '2.12.3',
    stable_repo_url => 'http://mirror.azure.cn/kubernetes/charts',
    tiller_image    => 'registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.12.3',
    env             => ['HOME=/root', 'KUBECONFIG=/etc/kubernetes/ssl/admin.kubeconfig.yaml']
}
helm::repo { 'douban':
    ensure    => 'present',
    repo_name => 'douban',
    url       => 'https://charts.douban.com/douban/',
}
helm::repo_update { 'update helm repos': }
# deploy helm charts from douban
helm::charts::douban { 'helpdesk': }
