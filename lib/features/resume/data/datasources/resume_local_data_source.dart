import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:resumely/core/errors/exceptions.dart';
import 'package:resumely/features/resume/data/models/resume_model.dart';
import 'package:uuid/uuid.dart';

abstract class ResumeLocalDataSource {
  Future<ResumeModel> getActiveResume();
  Future<List<ResumeModel>> getAllResumes();
  Future<void> saveResume(ResumeModel resume);
  Future<void> deleteResume(String id);
  Future<List<ExportRecordModel>> getExportHistory();
  Future<void> addExportRecord(ExportRecordModel record);
  Future<void> clearExportHistory();
}

const String resumeBoxName = 'resumes_box';
const String activeResumeKey = 'active_resume_id';
const String exportsBoxName = 'exports_box';

class ResumeLocalDataSourceImpl implements ResumeLocalDataSource {
  final Box<String> resumeBox;
  final Box<String> exportsBox;

  ResumeLocalDataSourceImpl({
    required this.resumeBox,
    required this.exportsBox,
  });

  ResumeModel _defaultResume() {
    const uuid = Uuid();
    return ResumeModel(
      id: uuid.v4(),
      photo: null,
      fullName: 'Alex Carter',
      title: 'Senior Product Designer',
      email: 'alex.carter@resumely.app',
      phone: '+1 (555) 019-2834',
      location: 'San Francisco, CA',
      website: 'linkedin.com/in/alexcarter',
      objective:
          'Product designer with 6+ years crafting human-centered digital experiences and design systems.',
      experiences: [
        ExperienceModel(
          id: uuid.v4(),
          role: 'Senior Product Designer',
          company: 'Northwind Tech',
          start: '2022',
          end: 'Present',
          description:
              'Led design system adoption across 4 product teams. Improved sprint velocity by 25%.',
        ),
        ExperienceModel(
          id: uuid.v4(),
          role: 'UX Designer',
          company: 'Vertex Studio',
          start: '2019',
          end: '2022',
          description:
              'Redesigned core checkout funnel resulting in a 14% uplift in conversion rate.',
        ),
      ],
      educations: [
        EducationModel(
          id: uuid.v4(),
          school: 'UC Berkeley',
          degree: 'B.A. Cognitive Science & Design',
          start: '2015',
          end: '2019',
        ),
      ],
      skills: const [
        'Figma',
        'Design Systems',
        'Prototyping',
        'User Research',
        'Flutter',
        'UI/UX',
      ],
      certificates: [
        CertificateModel(
          id: uuid.v4(),
          name: 'NN/g UX Master Certified',
          issuer: 'Nielsen Norman Group',
          year: '2023',
        ),
      ],
      tag: 'Active',
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<ResumeModel> getActiveResume() async {
    try {
      final activeId = resumeBox.get(activeResumeKey);
      if (activeId != null) {
        final raw = resumeBox.get(activeId);
        if (raw != null) {
          return ResumeModel.fromJson(jsonDecode(raw));
        }
      }

      // If no active resume exists yet, create default one
      final defaultRes = _defaultResume();
      await saveResume(defaultRes);
      return defaultRes;
    } catch (e) {
      throw CacheException(message: 'Failed to load active resume: $e');
    }
  }

  @override
  Future<List<ResumeModel>> getAllResumes() async {
    try {
      final List<ResumeModel> list = [];
      for (var key in resumeBox.keys) {
        if (key != activeResumeKey) {
          final raw = resumeBox.get(key);
          if (raw != null) {
            list.add(ResumeModel.fromJson(jsonDecode(raw)));
          }
        }
      }
      if (list.isEmpty) {
        final def = await getActiveResume();
        return [def];
      }
      list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return list;
    } catch (e) {
      throw CacheException(message: 'Failed to load resumes: $e');
    }
  }

  @override
  Future<void> saveResume(ResumeModel resume) async {
    try {
      final jsonStr = jsonEncode(resume.toJson());
      await resumeBox.put(resume.id, jsonStr);
      await resumeBox.put(activeResumeKey, resume.id);
    } catch (e) {
      throw CacheException(message: 'Failed to save resume: $e');
    }
  }

  @override
  Future<void> deleteResume(String id) async {
    try {
      await resumeBox.delete(id);
      final activeId = resumeBox.get(activeResumeKey);
      if (activeId == id) {
        await resumeBox.delete(activeResumeKey);
      }
    } catch (e) {
      throw CacheException(message: 'Failed to delete resume: $e');
    }
  }

  @override
  Future<List<ExportRecordModel>> getExportHistory() async {
    try {
      final List<ExportRecordModel> list = [];
      for (var key in exportsBox.keys) {
        final raw = exportsBox.get(key);
        if (raw != null) {
          list.add(ExportRecordModel.fromJson(jsonDecode(raw)));
        }
      }
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    } catch (e) {
      throw CacheException(message: 'Failed to load exports: $e');
    }
  }

  @override
  Future<void> addExportRecord(ExportRecordModel record) async {
    try {
      final jsonStr = jsonEncode(record.toJson());
      await exportsBox.put(record.id, jsonStr);
    } catch (e) {
      throw CacheException(message: 'Failed to add export record: $e');
    }
  }

  @override
  Future<void> clearExportHistory() async {
    try {
      await exportsBox.clear();
    } catch (e) {
      throw CacheException(message: 'Failed to clear exports: $e');
    }
  }
}
