{{/*
Expand the name of the chart.
*/}}
{{- define "mrr-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mrr-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mrr-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mrr-chart.labels" -}}
helm.sh/chart: {{ include "mrr-chart.chart" . }}
{{ include "mrr-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mrr-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mrr-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels for abnf tool
*/}}
{{- define "mrr-chart-abnf.labels" -}}
helm.sh/chart: {{ include "mrr-chart.chart" . }}
{{ include "mrr-chart-abnf.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for abnf tool
*/}}
{{- define "mrr-chart-abnf.selectorLabels" -}}
app.kubernetes.io/name: {{ printf "%s-abnf" (include "mrr-chart.name" .) }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels for bootstrap job
*/}}
{{- define "mrr-chart-bootstrap.labels" -}}
helm.sh/chart: {{ include "mrr-chart.chart" . }}
{{ include "mrr-chart-bootstrap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for bootstrap job
*/}}
{{- define "mrr-chart-bootstrap.selectorLabels" -}}
app.kubernetes.io/name: {{ printf "%s-bootstrap" (include "mrr-chart.name" .) }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mrr-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mrr-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
