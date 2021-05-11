// Copyright 2021 Red Hat, Inc
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package main

// File metrics contains all metrics that needs to be exposed to Prometheus and
// indirectly to Grafana.

import (
	"github.com/RedHatInsights/insights-operator-utils/metrics"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
)

// Metrics names
const (
	ConsumedMessagesName      = "consumed_messages"
	ConsumingErrorsName       = "consuming_errors"
	ParsedIncomingMessageName = "parse_incoming_message"
	CheckSchemaVersionName    = "check_schema_version"
	MarshalReportName         = "marshal_report"
)

// Metrics helps
const (
	ConsumedMessagesHelp      = "The total number of messages consumed from Kafka"
	ConsumingErrorsHelp       = "The total number of errors during consuming messages from Kafka"
	ParsedIncomingMessageHelp = "The total number of parsed messages"
	CheckSchemaVersionHelp    = "The total number of messages with successfull schema check"
	MarshalReportHelp         = "The total number of marshaled reports"
)

// ConsumedMessages shows number of messages consumed from Kafka by aggregator
var ConsumedMessages = promauto.NewCounter(prometheus.CounterOpts{
	Name: ConsumedMessagesName,
	Help: ConsumedMessagesHelp,
})

// ConsumingErrors shows the total number of errors during consuming messages from Kafka
var ConsumingErrors = promauto.NewCounter(prometheus.CounterOpts{
	Name: ConsumingErrorsName,
	Help: ConsumingErrorsHelp,
})

// ParsedIncomingMessage shows the number of parsed messages
var ParsedIncomingMessage = promauto.NewCounter(prometheus.CounterOpts{
	Name: ParsedIncomingMessageName,
	Help: ParsedIncomingMessageHelp,
})

// CheckSchemaVersion shows the number of messages with correct schema version
var CheckSchemaVersion = promauto.NewCounter(prometheus.CounterOpts{
	Name: CheckSchemaVersionName,
	Help: CheckSchemaVersionHelp,
})

// MarshalReport shows the number of messages with correct schema version
var MarshalReport = promauto.NewCounter(prometheus.CounterOpts{
	Name: MarshalReportName,
	Help: MarshalReportHelp,
})

// AddMetricsWithNamespace register the desired metrics using a given namespace
func AddMetricsWithNamespace(namespace string) {
	metrics.AddAPIMetricsWithNamespace(namespace)

	prometheus.Unregister(ConsumedMessages)
	prometheus.Unregister(ConsumingErrors)
	prometheus.Unregister(ParsedIncomingMessage)
	prometheus.Unregister(CheckSchemaVersion)

	ConsumedMessages = promauto.NewCounter(prometheus.CounterOpts{
		Namespace: namespace,
		Name:      ConsumedMessagesName,
		Help:      ConsumedMessagesHelp,
	})

	ConsumingErrors = promauto.NewCounter(prometheus.CounterOpts{
		Namespace: namespace,
		Name:      ConsumingErrorsName,
		Help:      ConsumingErrorsHelp,
	})

	ParsedIncomingMessage = promauto.NewCounter(prometheus.CounterOpts{
		Namespace: namespace,
		Name:      ParsedIncomingMessageName,
		Help:      ParsedIncomingMessageHelp,
	})

	CheckSchemaVersion = promauto.NewCounter(prometheus.CounterOpts{
		Namespace: namespace,
		Name:      CheckSchemaVersionName,
		Help:      CheckSchemaVersionHelp,
	})

	MarshalReport = promauto.NewCounter(prometheus.CounterOpts{
		Namespace: namespace,
		Name:      MarshalReportName,
		Help:      MarshalReportHelp,
	})
}
