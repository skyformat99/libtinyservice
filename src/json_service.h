#ifndef __JSON_SERVICE_H__
#define __JSON_SERVICE_H__

#include <rapidjson/document.h>
#include <rapidjson/prettywriter.h>

namespace rpc {
namespace json {

struct Service
{
    virtual void run(const rapidjson::Document &indom, rapidjson::Document &outdom) = 0;
};

class ServiceCaller
{
  public:
    ServiceCaller() {}
    virtual ~ServiceCaller() {}

    static ServiceCaller *getInstance();

    void rpcCall(std::string &_return, const std::string &jsonarg, const std::string &module);
};

}
}

#endif // __JSON_SERVICE_H__
