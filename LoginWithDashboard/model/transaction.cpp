#include "transaction.h"

int Transaction::id() const { return m_id; }
QString Transaction::type() const { return m_type; }
QString Transaction::description() const { return m_description; }
QString Transaction::time() const { return m_time; }
double Transaction::amount() const { return m_amount; }
